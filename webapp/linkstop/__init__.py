from django.conf import settings

from urlparse import urlsplit
from os.path import join



from hashlib import md5

def hash_path(normalized_url):
    url_hash = md5(normalized_url).hexdigest()[:9]
    return "/".join(url_hash[i:i+3] for i in xrange(0, len(url_hash), 3))


_VALID_NORMALIZED_CHARS = set('0123456789abcdefghijklmnopqrstuvwxyz_-.~/:')
def url_normalize(url):
    if '://' not in url:
        url = 'http://' + url
    scheme, netloc, path, query, fragment = urlsplit(url.lower())
    url = '/'.join(c for c in (netloc, path, query) if c).replace('//', '/')
    url = ''.join(c for c in url if c in _VALID_NORMALIZED_CHARS)
    return url


def url_normalize_base(url):
    if '://' not in url:
        url = 'http://' + url
    scheme, netloc, path, query, fragment = urlsplit(url.lower())
    if netloc.startswith('www.'):
        netloc = netloc[4:]
    url = netloc.replace('//', '/')
    url = ''.join(c for c in url if c in _VALID_NORMALIZED_CHARS)
    return url


def url_to_filename(url):
    url = url.lower()
    url = url.replace('/', '-').replace('.', '-dot-').replace(':', '_').replace('~', '_td_')
    return url

def url_normalize_to_path(url):
    url = url_normalize(url)
    hp = hash_path(url)
    url = url_to_filename(url)
    return '/'.join((hp, url))

def normalized_url_to_path(normalized_url):
    hp = hash_path(normalized_url)
    filename = url_to_filename(normalized_url)
    return '/'.join((hp, filename))

def get_favicon_size_url(normalized_url, size):
    url_path = url_to_filename(normalized_url)
    hp = hash_path(normalized_url)
    return join(settings.FAVICON_URL, hp, url_path, 'icon%s.png'%str(size))
