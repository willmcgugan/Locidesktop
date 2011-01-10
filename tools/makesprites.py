#!/usr/bin/env python
import sys
from fs.osfs import OSFS
import Image

img_fs = OSFS(sys.argv[1])

imgs = []

for path in img_fs.listdir(wildcard='*.png'):
    img = Image.open(img_fs.getsyspath(path))
    size = img.size[0]

    if size != 16:
        continue

    imgs.append((path, img))

sprite = Image.new('RGBA', (16, len(imgs)*16))

imgs.sort(key=lambda i:i[0])

sprite_text_f = img_fs.open('sprites.txt', 'wt')

for i, (path, img) in enumerate(imgs):
    y = i*16
    sprite.paste(img, (0, y))
    sprite_text_f.write( "%i\t%s\n" % (y, path))

sprite.save(img_fs.getsyspath('sprites.png'))

sprite_text_f.close()
