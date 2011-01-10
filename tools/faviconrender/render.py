#!/usr/bin/env python

import Image
from math import *

class Col(object):

    def __init__(self, r, g, b, a=1.0):
        self.r = r
        self.g = g
        self.b = b
        self.a = a

class ImageScan(object):

    def __init__(self, image):

        self.image = image
        self.scan()

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
            for x in range(w):

                c = getpixel( (x, h-1-y) )

                # Skip transparent, and almost transparent pixels
                if c[-1] > 32:
                    c = Col( *(i/255.0 for i in c) )

                    #c.r = c.a * c.r + 1.-c.a
                    #c.g = c.a * c.g + 1.-c.a
                    #c.b = c.a * c.b + 1.-c.a

                    c.r += c.r*(1-c.a)
                    c.g += c.g*(1-c.a)
                    c.b += c.b*(1-c.a)

                    ix = x * step_w
                    iy = y * step_h
                    row.append( (ix, iy, c) )

            pixels.append(row)

        self.pixels = pixels

    def __iter__(self):
        return iter(self.pixels)


if __name__ == "__main__":

    import sys
    filename = sys.argv[1]

    image = Image.open(filename)
    image = image.convert('RGBA')

    ims = ImageScan(image)

    td = {}
    td['image'] = ims


    from mako.template import Template

    output_filename = filename.split('.')[0] + '_favicon.png'

    mytemplate = Template(filename='favicon.pov')
    open('out.pov', 'w').write(mytemplate.render(**td))

    import os
    os.system('povray out.pov -O%s +A0.1 -w64 -h64 +UA +R8' % output_filename)
    print "Output", output_filename