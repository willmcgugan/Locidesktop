import Image
import numpy as np

def maketilable(src_path, dst_path, w=None, h=None):
    src_img = Image.open(src_path)
    src_img = src_img.convert('RGB')
    src = np.asarray(src_img)

    src_w, src_h, ncolors = src.shape

    if w is None:
        w = src_w
    if h is None:
        h = src_h

    def warp(p, l, dl):
        i = p * 1.0 / l
        i = np.sin(i*np.pi*2 + np.pi)
        i = i / 2.0 + .5
        return abs(i * dl)

    xp = warp(np.arange(w), w-1, src_w-1)[:,np.newaxis]
    yp = warp(np.arange(h), h-1, src_h-1)[np.newaxis,:]

    x = xp.astype(int)
    y = yp.astype(int)

    x1 = (x + 1) % src_w
    y1 = (y + 1) % src_h

    a = src[x, y]
    b = src[x1, y]
    c = src[x, y1]
    d = src[x1, y1]

    frac_x = (xp - np.floor(xp))[...,np.newaxis]
    frac_y = (yp - np.floor(yp))[...,np.newaxis]
    
    d *= frac_x * frac_y
    c *= (1.-frac_x) * frac_y
    b *= frac_x * (1. - frac_y)
    a *= (1.-frac_x) * (1. - frac_y)

    dst = a + b + c + d
    dst_img = Image.fromarray(dst, 'RGB')
    dst_img.save(dst_path)

if __name__ == "__main__":
    import sys
    try:
        src_path = sys.argv[1]
        dst_path = sys.argv[2]
    except IndexError:
        print "<source image path>, <destination image path>"
    else:
        maketilable(src_path, dst_path)