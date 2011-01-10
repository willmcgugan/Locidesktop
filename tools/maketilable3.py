import Image
import numpy as np
import scipy.ndimage

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

    x = warp(np.arange(w), w-1, src_w-1)
    y = warp(np.arange(h), h-1, src_h-1)

    coords = np.broadcast_arrays(*np.ix_(x, y))

    dst = np.empty((w, h, 3), src.dtype)
    for j in xrange(3):
        dst[:,:,j] = \
            scipy.ndimage.map_coordinates(src[:,:,j], 
                                          coords,
                                          mode='wrap',
                                          order=3)

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