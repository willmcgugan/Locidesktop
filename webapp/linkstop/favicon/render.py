import os
import random
from os.path import join, dirname


import Image
import ImageOps
import ImageFilter
import ImageEnhance


from math import *

from mako.template import Template

class Col(object):

    def __init__(self, r, g, b, a=1.0):
        self.r = r
        self.g = g
        self.b = b
        self.a = a

class ImageScan(object):

    def __init__(self, image):

        self.image = image.convert('RGBA')

        if self.any_translucent_pixels():

            image = self.image
            background = Image.open(join(dirname(__file__), 'iconfade.png'))

            scale_w = int(background.size[0] * 0.70)

            w, h = background.size
            x = (w - scale_w) / 2


            #alpha = alpha.filter(ImageFilter.BLUR)

            #image = ImageOps.expand(image, 2)
            alpha = image.split()[-1]

            #iw, ih = image.size
            #getpixel = alpha.getpixel
            #putpixel = alpha.putpixel
            #for ay in xrange(iw):
            #    for ax in xrange(ih):
            #        c = getpixel((ax, ay))
            #        if c:
            #            putpixel((ax, ay), 255)
            #        #
                    #if c[-1]:
                    #    c = [i/255.0 for i in c]
                    #    r, g, b, a = c
                    #    r = a * r + 1.-a
                    #    g = a * g + 1.-a
                    #    b = a * b + 1.-a
                    #    a = 255
                    #    alpha.putpixel((x, y), tuple(int(c*255.0) for c in (r, g, b, a)))



            alpha = alpha.resize((scale_w, scale_w), Image.BILINEAR)

            border_alpha = Image.new('L', (scale_w+40, scale_w+40))
            border_alpha.paste(alpha, (20, 20))
            alpha = border_alpha

            #alpha = ImageOps.expand(image, 20)
            alpha = alpha.filter(ImageFilter.MaxFilter(7))
            alpha = alpha.filter(ImageFilter.MaxFilter(7))
            alpha = alpha.filter(ImageFilter.BLUR)
            #alpha = alpha.filter(ImageFilter.SHARPEN)

            #alpha = ImageEnhance.Contrast(alpha).enhance(1.3)



            image = image.resize((scale_w, scale_w), Image.NEAREST)
            image = ImageOps.expand(image, 20)

            edge = Image.new('RGBA',alpha.size, (255, 255, 255, 0))
            edge.putalpha(alpha)

            x = (background.size[0]-edge.size[0])/2
            background.paste((255, 255, 255), (x, x), edge)


            background.paste(image, (x, x), image)
            #image.paste(alpha, None, alpha)

            #image.putalpha(alpha)
            #image.show()


            self.image = image

            #background = Image.open(join(dirname(__file__), 'iconfade.png'))
            #background.thumbnail(self.image.size)
            #background.paste(self.image, (x, x), self.image)
            self.image = background



        self.scan()

    def any_translucent_pixels(self):
        w, h = self.image.size
        getpixel = self.image.getpixel
        for y in range(h):
            for x in xrange(w):
                a = getpixel((x, y))[3]
                if a not in (0, 255):
                    return True
        return False

    def scan(self):

        w, h = self.image.size
        step_w = 1.0 / w
        step_h = 1.0 / h
        self.pixel_x_size = step_w
        self.pixel_y_size = step_h

        im = self.image
        getpixel = im.getpixel

        pixels = []

        for y in range(h):

            row = []
            iy = y * step_h
            for x in range(w):

                c = getpixel( (x, h-1-y) )

                # Skip transparent, and almost transparent pixels
                if c[-1]:# > 32:
                    c = Col( *(i/255.0 for i in c) )


                    ix = x * step_w
                    #iy = y * step_h
                    row.append( (ix, iy, c) )

            pixels.append(row)

        self.pixels = pixels

    def __iter__(self):
        return iter(self.pixels)


def render(size, input_filename, output_filename, template_filename):

    pov_filename = '/tmp/%s.pov' % ''.join(random.choice('abcdefghijklmnopqrstuvwxyz') for _ in xrange(12))

    image = Image.open(input_filename)

    opacity = 'a' in image.mode.lower()
    opacity = False

    image = image.convert('RGBA')

    ims = ImageScan(image)

    td = {}
    td['image'] = ims
    td['has_opacity'] = opacity

    povtemplate = Template(filename=template_filename)
    open(pov_filename, 'w').write(povtemplate.render(**td))

    w, h = size
    print "Rendering %ix%i" % (w, h)
    pov_cmd = 'povray "%(pov_filename)s" -O"%(output_filename)s" +A0.1 -w%(w)i -h%(h)i +UA +R4 -d -V -GA 2> /dev/null' % locals()

    print pov_cmd
    os.system(pov_cmd)

    os.system('optipng -o5 -q "%s"' % output_filename)
    return True


if __name__ == "__main__":

    render( (128, 128), '/home/will/projects/linkstop/tools/faviconrender/favicons/flickr.png', 'fav128.png', 'favicon.pov' )
    