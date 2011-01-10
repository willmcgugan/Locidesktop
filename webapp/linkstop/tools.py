import simplejson as json
#import json

import re
from functools import partial
from django.conf import settings

class JSONPropertyDescriptor(object):
    def __init__(self, name):
        self._name = name
        self._data = None
    def __get__(self, instance, owner):
        if self._data is not None:
            return self._data
        data = getattr(instance, self._name)
        if not data:
            return {}
        return json.loads(getattr(instance, self._name))

    def __set__(self, instance, value):
        setattr(instance, self._name, json.dumps(value))
        self._data = value


re_icon_url = re.compile(r'\[(.*?)\]')
def parse_icon_url(url):
    """ Parses a url containing sizes for icons in to a dictionary that maps the
    size on to a unique url.

    >>> parse_icon_url('/media/images/icons/icon[16,32,64].png')
    {16: '/media/images/icons/icon16.png', 32: '/media/images/icons/icon32.png', 64: '/media/images/icons/icon64.png'}

    """
    sizes = []
    sizes_splits = {}
    for match in re_icon_url.findall(url):
        sizes_split = [int(s) for s in match.split(',') if s.strip().isdigit()]
        sizes_splits[match] = set(sizes_split)
        sizes += sizes_split
    sizes = set(sizes)

    def repl(size, m):
        sizes = m.group(1)
        return str(size) if size in sizes_splits[sizes] else ''

    return dict( zip(sizes, (re_icon_url.subn(partial(repl, size), url)[0] for size in sizes)) )


def get_icon_url_map(url, sizes):

    urls = parse_icon_url(url)

    if not urls:
        return dict( zip( sizes, [url] * len(sizes) ) )

    url_map = {}

    sizes = sorted(sizes)
    url_sizes = sorted(urls.keys())
    max_url = urls[url_sizes[-1]]
    min_url = urls[url_sizes[0]]

    for size in sizes:
        if size in urls:
            url_map[size] = urls[size]
        else:
            url_map[size] = max_url if size > url_sizes[-1] else min_url

    return dict(url_map)


class IconPackUrl(object):
    def __init__(self, url):
        pass

SLUG_CHARS = set('abcdefghijklmnopqrstuvwxyz1234567890-_ ')
re_spaces = re.compile(u'\s+')
def slugify(text):
    text = text.strip().lower()
    slug = ''.join(c for c in text if c in SLUG_CHARS)
    slug, count = re_spaces.subn('-', slug.strip())
    return slug

from linkstop.djangojinja2 import render_to_string
from django.core.mail import send_mail
def send_template_email(subject, template_name, data, recipient):

    mail = render_to_string('email/%s.txt'%template_name, data)
    if settings.SEND_EMAIL:
        send_mail(subject, mail, settings.DEFAULT_FROM_EMAIL, [recipient], fail_silently=False)
    else:
        print mail

if __name__ == "__main__":
    url='/media/icons/size/[16,32,64,128]/web.png'
    urls = parse_icon_url(url)
    for k, v in sorted(get_icon_url_map(url, [8, 16, 32, 64, 128, 256]).items()):
        print k, v
