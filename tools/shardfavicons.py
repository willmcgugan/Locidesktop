import sys
from fs.osfs import OSFS
from fs.utils import *
from os.path import basename
import cPickle as pickle


from hashlib import md5

def hash_path(normalized_url):
    url_hash = md5(normalized_url).hexdigest()[:9]
    return "/".join(url_hash[i:i+3] for i in xrange(0, len(url_hash), 3))

def url_to_filename(url):
    url = url.lower()
    url = url.replace('/', '-').replace('.', '-dot-').replace(':', '_').replace('~', '_td_')
    return url


try:
    src = sys.argv[1]
    dst = sys.argv[2]
except IndexError:
    src = '~/projects/linkstop/webapp/linkstop/media/faviconsx'
    dst = '~/projects/linkstop/webapp/linkstop/media/favicons'

src_fs = OSFS(src)
dst_fs = OSFS(dst)

count = 0
max_count = 2
for path in src_fs.listdir(dirs_only=True):
    icon_fs = src_fs.opendir(path)
    if icon_fs.isfile('scan.pik'):
        try:
            icon = pickle.load(icon_fs.open('scan.pik'))
        except Exception, e:
            print "%s (%s)" % (str(e), path)
            continue
        normalized_url = icon['normalized_url']
        out_dir = hash_path(normalized_url) + '/' + url_to_filename(normalized_url)
        print out_dir

        dest_dir_fs = dst_fs.makeopendir(out_dir, recursive=True)


        movedir(icon_fs, dest_dir_fs, overwrite=True, ignore_errors=True)

        #count += 1

    if count >= max_count:
        break
