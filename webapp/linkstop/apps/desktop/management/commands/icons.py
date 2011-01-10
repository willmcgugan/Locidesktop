from __future__ import with_statement
from django.core.management.base import BaseCommand, CommandError
from linkstop.apps.desktop.models import *
from django.db.transaction import commit_on_success
from django.conf import settings

import re
import os, os.path
from collections import defaultdict
import shutil
import ConfigParser

from fs.osfs import OSFS
from fs.path import *

import Image

class Command(BaseCommand):

    """ python manage.py icons import crystal_project [SIZE]x[SIZE]/[CATEGORY]/[NAME].png """


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
    def cmd_import(self, *params, **options):

        """ Imports an icon set """

        media_fs = OSFS(settings.MEDIA_ROOT)
        iconsets_fs = media_fs.opendir('iconsets')

        try:
            iconset_name = params[0]
            iconsets = iconsets_fs.listdir(wildcard = iconset_name, dirs_only=True)

        except IndexError, e:
            print "<catalog name, or wildcard>"
            return


        for iconset_name in iconsets:

            iconset_fs = iconsets_fs.opendir(iconset_name)

            iconset_config_path = iconset_fs.getsyspath('iconset.cfg')
            cfg = ConfigParser.ConfigParser()
            cfg.read(iconset_config_path)

            iconset_path = cfg.get('iconset', 'paths')

            re_substitute = re.compile(r'\[.*?\]')

            class Category(object):
                def __init__(self):
                    self.sizes = set()
                    self.icons = {}
                    self.icon_sizes = defaultdict(lambda:set())
                def __repr__(self):
                    return repr(self.sizes) + " " + repr(self.icons)


            categories = defaultdict(lambda:Category())

            ALLOWED_SIZES = set(settings.DESKTOP_ICON_SIZES)

            print "Scanning %s for images..." % iconset_name
            for filename in iconsets_fs.walkfiles(wildcard="*.png"):

                filename_re = iconset_path.replace('.', '\.')
                filename_re = iconset_path.replace('[SIZE]', '(?P<size>\d+?)', 1).\
                    replace('[CATEGORY]', '(?P<category>\w+?)', 1).\
                    replace('[NAME]', '(?P<name>\w+?)', 1)

                filename_re = re_substitute.sub('.+', filename_re)
                re_filename = re.compile(filename_re)
                match = re_filename.search(filename)

                if match is not None:
                    match_data = match.groupdict()

                    name = match_data['name']
                    category_name = match_data['category']
                    size = int(match_data['size'])

                    if size not in ALLOWED_SIZES:
                        continue

                    category = categories[category_name]

                    path = os.path.join('iconsets', iconset_name, iconset_path.replace('[CATEGORY]', category_name).replace('[NAME]', name))
                    url = path

                    name = name.replace(' ', '_')
                    category.icons[name] = url, path
                    category.icon_sizes[name].add(size)
                    category.sizes.add(size)

            try:
                IconCatalog.objects.get(name=iconset_name).delete()
            except IconCatalog.DoesNotExist:
                pass
            icon_catalog, created = IconCatalog.objects.get_or_create(name=iconset_name)
            icon_catalog.icon_set.all().delete()
            print "Created IconCatalog:", iconset_name

            icon_catalog.icon_set.all().delete()
            #Icon.objects.filter(caicon_catalog).delete();
            for cat_name, category in sorted(categories.items()):

                sizes = ','.join(str(s) for s in sorted(category.sizes))
                print "%s (%s):" % (cat_name, sizes)

                count = 0
                for icon_name, (icon_url, icon_path) in sorted(category.icons.items()):

                    try:
                        sizes = ','.join(str(s) for s in sorted(category.icon_sizes[icon_name]))
                        icon_url = icon_url.replace('\\', '/' )
                        icon, created = Icon.objects.get_or_create( catalog = icon_catalog,
                                                                    category = cat_name,
                                                                    name = icon_name,
                                                                    path = icon_path,
                                                                    img_url = icon_url,
                                                                    sizes = sizes)
                    except:
                        continue
                    if created:
                        count += 1

                    icon_sizes = category.icon_sizes[icon_name]
                    largest_size = max(icon_sizes)
                    largest_icon_path = icon_path.replace('[SIZE]', str(largest_size))

                    largest_icon_img = Image.open(os.path.join(settings.MEDIA_ROOT, largest_icon_path))
                    for force_size in settings.DESKTOP_FORCE_ICON_SIZES:
                        if force_size not in icon_sizes:
                            new_icon_path = os.path.join(settings.MEDIA_ROOT, icon_path.replace('[SIZE]', str(force_size)))
                            new_icon_path = new_icon_path.replace('\\', '/')
                            new_img = largest_icon_img.copy()
                            new_img = new_img.resize((force_size, force_size), Image.BICUBIC)
                            try:
                                os.makedirs(os.path.dirname(new_icon_path))
                            except OSError:
                                pass

                            new_img.save(new_icon_path, optimize=True)
                            print "Generated missing icon:", new_icon_path[len(settings.MEDIA_ROOT)+1:]

                print "\tadded %i icons" % count

        print "OK"
        print "Now would be a good time to run \"manage.py icons makepreviews\""


    def cmd_optimize(self, *params, **options):

        """ Optimizes icon images. """

        media_fs = OSFS(settings.MEDIA_ROOT)
        iconsets_fs = media_fs.opendir('iconsets')

        count = 0
        for filename in list(iconsets_fs.walkfiles(wildcard="*.png")):

            sys_filename = iconsets_fs.getsyspath(filename)
            try:
                os.system('optipng -o3 -q "%s"' % sys_filename)
            except Exception, e:
                print "Error:", str(e)
            else:
                print "Optimized", filename

            #sys_filename = iconsets_fs.getsyspath(filename)
            #img = Image.open(sys_filename)
            #img.save(sys_filename, optimize=True)
            #print '.',
            count += 1

        print
        print "%s images processed" % count


    def cmd_makeadminpreviews(self, *params, **options):
        try:
            iconset = params[0]
        except IndexError:
            iconset = ''

        icon_fs = OSFS(settings.MEDIA_ROOT).opendir('iconsets')
        if params:
            icon_fs = icon_fs.opendir(params[0])

        done_dirs = set()
        for path in icon_fs.walkfiles(wildcard='*.png'):
            dirpath = dirname(path)
            png_path = icon_fs.getsyspath(path)
            img = Image.open(png_path).convert('RGBA')
            background_img = Image.new('RGB', img.size, (255, 255, 255))

            background_img.paste(img, None, img)

            new_path = os.path.splitext(png_path)[0] + '.jpg'
            background_img.save(new_path)
            if dirpath not in done_dirs:
                print "Generating admin previews in %s/*" % dirpath
                done_dirs.add(dirpath)            

    def cmd_makepreviews(self, *params, **options):

        PREVIEW_ICON_SIZE = 32
        WIDTH_COUNT = 11
        BORDER = 5

        ICON_DIMENSIONS = (BORDER*2 + PREVIEW_ICON_SIZE)

        preview_width = ICON_DIMENSIONS * WIDTH_COUNT

        media_fs = OSFS(settings.MEDIA_ROOT)
        media_fs.makedir('iconsetpreviews', allow_recreate=True)
        previews_fs = media_fs.opendir('iconsetpreviews')

        for catalog in IconCatalog.objects.all():

            for category in catalog.get_categories():

                filename =  "%s.%s.jpg" % (catalog.name, category)

                icons = catalog.icon_set.filter(category=category).order_by('name')
                num_icons = icons.count()

                icons_height_count = (num_icons + WIDTH_COUNT-1) // WIDTH_COUNT
                preview_height = icons_height_count * ICON_DIMENSIONS

                preview_img = Image.new('RGB', (preview_width, preview_height), (255, 255, 255))
                print preview_width, preview_height

                for i, icon in enumerate(icons):

                    y, x = divmod(i, WIDTH_COUNT)

                    pth = icon.path.replace('[SIZE]', str(PREVIEW_ICON_SIZE))

                    icon_pth = media_fs.getsyspath(pth)

                    img = Image.open(icon_pth)
                    if img.size[0] != img.size[1]:
                        img = img.crop((0, 0, PREVIEW_ICON_SIZE, PREVIEW_ICON_SIZE))
                    try:
                        preview_img.paste(img, (x*ICON_DIMENSIONS+BORDER, y*ICON_DIMENSIONS+BORDER), img)
                    except ValueError:
                        preview_img.paste(img, (x*ICON_DIMENSIONS+BORDER, y*ICON_DIMENSIONS+BORDER))


                sys_filename = previews_fs.getsyspath(filename)
                print sys_filename
                preview_img.save(previews_fs.getsyspath(filename), quality=75)
