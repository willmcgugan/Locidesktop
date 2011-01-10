from urlparse import urlsplit, urljoin
import os.path
import random

from django.core.management.base import BaseCommand, CommandError
from linkstop.apps.desktop.models import *
from django.conf import settings

from linkstop.favicon import download_favicon
from linkstop.favicon.downloader import DownloaderError
from linkstop.favicon import render
from linkstop import url_normalize, url_normalize_to_path
from threading import Thread

from django.db.transaction import *

from fs.osfs import OSFS
import fs.utils
from urllib2 import URLError

import Image

try:
    import cPickle as pickle
except ImportError:
    import pickle

def url_to_path(url):
    url = url_normalize_to_path(url)
    return 'favicons/' + url

def get_original_path(url, size=None):

    image_name = 'favicon.png' if size is None else 'favicon%s.png' % str(size)

    path = os.path.join(settings.MEDIA_ROOT, url_to_path(url), 'originals', 'icon.png')
    if not os.path.isfile(path):
        path = os.path.join(settings.MEDIA_ROOT, url_to_path(url), 'originals', 'icon-0.png')

    return path

def get_size_path(url, size):

    image_name = 'icon%s.png' % str(size)
    path = os.path.join(settings.MEDIA_ROOT, url_to_path(url), image_name)

    return path

def get_icon_directory(url):
    return os.path.join(settings.MEDIA_ROOT, url_to_path(url))

#def normalize_url(url):
#
#    scheme, netloc, path, query, fragment = urlsplit(url.lower())
#    url = '_'.join(s for s in (netloc, path, query) if s)
#    return url


class Command(BaseCommand):

    def handle(self, *params, **options):

        if not params:
            print "Sub-commands available:"
            for method in dir(self):
                if method.startswith('cmd_'):
                    print "\t%s" % method[4:]
            return

        sub_command = params[0]
        sub_command_callable = getattr(self, "cmd_"+sub_command, None)
        if sub_command_callable is None:
            print "No such command (%s)" % sub_command
            return

        return sub_command_callable(*params[1:], **options)

    @commit_on_success
    def cmd_get(self, *params, **options):

        try:
            url = params[0]
        except IndexError:
            print "get <url>"
            return

        media_fs = OSFS(settings.MEDIA_ROOT)
        media_fs.makedir('favicons', allow_recreate=True)

        favicon_path = url_to_path(url)
        favicon_fs = media_fs.makeopendir(favicon_path, recursive=True)

        orig_favicon_fs = favicon_fs.makeopendir('originals')

        output_path = orig_favicon_fs.getsyspath('orig')
        convert_path = orig_favicon_fs.getsyspath('icon.png')

        try:
            icon_info = download_favicon(url, output_path, convert_path)
        except URLError, e:
            print "ERROR: %s (%s)" % (e, url)
            return
        except Exception, e:
            print "ERROR: %s" % (e,)
            #print "No favicon found for %s" % url
            return

        got_sizes = []
        for png_path in orig_favicon_fs.listdir(wildcard='icon*.png'):

            img = Image.open(orig_favicon_fs.getsyspath(png_path))
            size = max(img.size)

            if size < 8:
                print "Skipping small icon (%s)" % png_path
                continue

            if size in got_sizes:
                print "Duplicate icon size, skipping %s" % png_path
                continue

            fname = 'icon%i.png' % size
            fs.utils.copyfile(orig_favicon_fs, png_path, favicon_fs, fname)
            got_sizes.append(size)

        sizes =','.join(str(s) for s in sorted(got_sizes))

        normalized_url = url_normalize(url)

        favicon, created =\
            FavIcon.objects.get_or_create( normalized_url=normalized_url,
                                           defaults=dict(url=url,
                                                         sizes=sizes,
                                                         original_sizes=sizes))

        favicon.url = url
        favicon.update()
        favicon.merge_sizes(got_sizes)

        if created:
            print "Created %s" % normalized_url

        else:
            print "Updated %s" % normalized_url


        favicon.export(favicon_fs.open('scan.pik', 'w'))
        pickle_path = favicon_fs.getsyspath('scan.pik')

        favicon.save()


    def cmd_render(self, *params, **options):

        icon_sizes = ','.join(str(s) for s in sorted(settings.DESKTOP_FORCE_ICON_SIZES))
        num_rendered = 0

        from linkstop.threadpool import ThreadPool
        thread_pool = ThreadPool(3, 6)

        try:
            max_renders = int(params[0])
        except IndexError:
            max_renders = None

        qs = FavIcon.objects.filter(rendered=False).order_by('pk')

        media_fs = OSFS(settings.MEDIA_ROOT)
        media_fs.makedir('favicons', allow_recreate=True)

        try:
            for favicon in qs:

                original_sizes = favicon.get_original_sizes()
                if not original_sizes:
                    continue

                remaining_sizes = sorted(set(settings.DESKTOP_FORCE_ICON_SIZES).difference(favicon.get_sizes()))

                for size in remaining_sizes:

                    print "Rendering %ix%i icon" % (size, size)

                    image_path = os.path.join( settings.MEDIA_ROOT,
                                               url_to_path(favicon.url), 'icon%i.png' % original_sizes[-1] )

                    output_path = get_size_path(favicon.url, size)

                    thread_pool.job( render,
                                     (size, size),
                                     image_path,
                                     output_path,
                                     settings.FAVICON_POV_SCENE )

                favicon.sizes = icon_sizes
                favicon.rendered = True
                favicon.save()


                #favicon_path = url_to_path(favicon.url)
                #favicon_fs = media_fs.makeopendir(favicon_path, recursive=True)

                favicon_fs = OSFS(get_icon_directory(favicon.url), create=True)
                favicon.export(favicon_fs.open('scan.pik', 'w'))
                #pickle_path = favicon_fs.getsyspath('scan.pik')

                num_rendered += 1

                if max_renders is not None and num_rendered >= max_renders:
                    break

        finally:
            thread_pool.flush_quit()

        print "%i icon sets rendered" % num_rendered


    def cmd_getautourls(self, *params, **options):

        from linkstop.threadpool import ThreadPool
        thread_pool = ThreadPool(100, 100)

        try:
            count = int(params[0])
        except IndexError:
            count = 10

        got_urls = set(fi[0].split('://', 1)[-1] for fi in FavIcon.objects.all().values_list('url'))

        try:
            for auto_url in AutoUrl.objects.all().exclude(url__in=got_urls).order_by('rank'):
                url = 'http://' + auto_url.url
                thread_pool.job(self.cmd_get, url)
        finally:
            thread_pool.flush_quit()


    def cmd_rerender(self, *params, **options):

        reply = raw_input("Mark all favicons for re-render? (Y/N) ")
        if 'y' not in reply.lower():
            print "Cancelled"
            return

        icons = FavIcon.objects.all()
        count = icons.count()
        for fi in icons:
            fi.mark_for_render()

        print count, "icons marked for re-render"


    def cmd_scan(self, *params, **options):

        favicons_fs = OSFS(settings.MEDIA_ROOT).makeopendir('favicons')

        for path in favicons_fs.walkdirs(wildcard="???"):
            icon_fs = favicons_fs.opendir(path)

            if icon_fs.isfile('scan.pik'):

                icon_sizes = ','.join(str(s) for s in sorted(int(p.split('.')[0][4:]) for p in icon_fs.listdir(wildcard='icon*.png')))
                if not icon_sizes:
                    continue

                favicon, created = FavIcon.import_(icon_fs.open('scan.pik'))
                if favicon is None:
                    continue

                old_sizes = favicon.sizes
                favicon.sizes = icon_sizes
                favicon.update()
                favicon.save()

                if created:
                    print "New object:\t", path
                else:
                    print path
                if old_sizes != favicon.sizes:
                    print "Icon sizes changed!\t", path
                    favicon.export(icon_fs.open('scan.pik', 'w'))
