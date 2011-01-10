import Image
from math import *

def maketilable(src_path, dst_path):
    src = Image.open(src_path)
    src = src.convert('RGB')
    src_w, src_h = src.size

    dst = Image.new('RGB', (src_w, src_h))
    w, h = dst.size

    def warp(p, l, dl):
        i = float(p) / l
        i = sin(i*pi*2 + pi)
        i = i / 2.0 + .5
        return abs(i * dl)

    warpx = [warp(x, w-1, src_w-1) for x in range(w)]
    warpy = [warp(y, h-1, src_h-1) for y in range(h)]

    get = src.load()
    put = dst.load()

    def getpixel(x, y):

        frac_x = x - floor(x)
        frac_y = y - floor(y)

        x1 = (x+1)%src_w
        y1 = (y+1)%src_h

        a = get[x, y]
        b = get[x1, y]
        c = get[x, y1]
        d = get[x1, y1]

        area_d = frac_x * frac_y
        area_c = (1.-frac_x) * frac_y
        area_b = frac_x * (1. - frac_y)
        area_a = (1.-frac_x) * (1. - frac_y)

        a = [n*area_a for n in a]
        b = [n*area_b for n in b]
        c = [n*area_c for n in c]
        d = [n*area_d for n in d]

        return tuple(int(sum(s)) for s in zip(a,b,c,d))


    old_status_msg = None
    status_msg = ''
    for y in xrange(h):

        status_msg = '%2d%% complete' % ((float(y) / h)*100.0)
        if status_msg != old_status_msg:
            print status_msg
        old_status_msg = status_msg

        for x in xrange(w):
            put[x, y] = getpixel(warpx[x], warpy[y])

    dst.save(dst_path)


if __name__ == "__main__":

    import sys
    try:
        src_path = sys.argv[1]
        dst_path = sys.argv[2]
    except IndexError:
        print "<source image path>, <destination image path>"
    else:
        maketilable(src_path, dst_path)
