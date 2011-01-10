from __future__ import with_statement
from urlparse import urlsplit, urljoin
from urllib2 import urlopen, URLError, Request
from urllib2 import HTTPError

import os
import re

from ico import load_icon
from cStringIO import StringIO

import Image

class DownloaderError(Exception):
    pass

class Downloader(object):

    re_link_tag = re.compile(r'<link(.*?)>')
    re_rel_attr = re.compile(r'rel="(.*?)"')
    re_href_attr = re.compile(r'href="(.*?)"')

    def __init__(self, url, dest_path, convert_path):
        self.url = url
        self.dest_path = dest_path
        self.convert_path = convert_path

    def __call__(self):

        scheme, netloc, path, query, fragment = urlsplit(self.url)

        favicon_ico_url = urljoin('%s://%s' % (scheme, netloc), 'favicon.ico')

        icon_url = None
        f_url = None
        try:
            req = Request(self.url, None,
                    {'User-agent': "Mozilla/4.0 (compatible; MSIE 5.5; Windows NT"})

            f_url = urlopen(req, timeout=5)

            code = f_url.getcode()
            if code != 200:
                raise DownloaderError("Non 200 response code (%i)" % code)

            content_type = f_url.headers.get('Content-Type').lower()

            #if 'image' not in content_type and 'icon' not in content_type:
            if 'html' not in content_type:
                raise DownloaderError("%s is not html (%s)" % (icon_url, content_type))

            page = f_url.read(16*1024)

        except URLError, e:
            pass
        except DownloaderError:
            pass
        else:
            for match in self.re_link_tag.finditer(page):

                tag_attrs = match.groups()[0]

                rel_match = self.re_rel_attr.search(tag_attrs)
                if rel_match is None:
                    continue

                rel = rel_match.groups()[0].strip().lower()
                if rel in ('icon', 'shortcut icon'):

                    href_match = self.re_href_attr.search(tag_attrs)
                    if href_match is None:
                        continue

                    icon_url = href_match.groups()[0]

                    if ':' not in icon_url:
                        icon_url = urljoin('%s://%s' % (scheme, netloc), icon_url)

                    break
        finally:
            if f_url is not None:
                f_url.close()

        if icon_url is None:
            icon_url = favicon_ico_url

        return self.download(icon_url, self.dest_path, self.convert_path)


    def download(self, icon_url, dest_path, convert_path):

        scheme, netloc, path, query, fragment = urlsplit(icon_url)
        ext = path.rsplit('.', 1)[-1]
        if len(ext) > 4:
            ext = icon_url.rsplit('.', 1)[-1]
        if len(ext) > 4:
            ext = 'ico'

        req = Request(icon_url, None,
                    {'User-agent': "Mozilla/4.0 (compatible; MSIE 5.5; Windows NT"})

        url_file = None
        try:
            url_file = urlopen(req, timeout=5)
            #print url_file.headers.get('Content-Type')

            code = url_file.getcode()
            if code != 200:
                raise DownloaderError("Non 200 response code (%i)" % code)

            content_type = url_file.headers.get('Content-Type', '').lower()

            #if 'image' not in content_type and 'icon' not in content_type:
            #if 'html' in content_type:
            #    raise DownloaderError("%s is not an image (%s)" % (icon_url, content_type))

            first_k = url_file.read(1024)

            if not first_k:
                raise DownloaderError("No data (%s)" % icon_url)

            if 'image' not in content_type and first_k.lstrip()[0] == '<':
                raise DownloaderError("Probably not an image (%s)" % icon_url)

            img_data = first_k + url_file.read(128*16384)

            if url_file.read(1):
                raise DownloaderError("File too big!")
        finally:
            if url_file is not None:
                url_file.close()

        out_path = dest_path + '.' + ext
        with open(out_path, 'w') as fout:
            fout.write(img_data)


        convert_cmd = 'convert "%s" "%s" 2> /dev/null' % (out_path, convert_path)
        if os.system(convert_cmd) != 0:
            os.remove(out_path)
            raise DownloaderError("Convert failed, probably not an image")


        print "Retrieved %s" % icon_url

        ret = {}
        ret['path'] = path

        return ret

def download_favicon(url, dest_path, convert_path):
    try:
        return Downloader(url, dest_path, convert_path)()
    except HTTPError:
        raise DownloaderError("Unable to download favicon for %s" % url)

if __name__ == "__main__":

    d = Downloader('http://www.willmcgugan.com')

    d()
