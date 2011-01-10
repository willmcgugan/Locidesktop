#!/usr/bin/env python

from collections import defaultdict


IGNORE_TLDS = frozenset(['.com', '.co.uk', '.net', '.org'])

def process():

    urls = [l.rstrip().partition(',')[-1] for l in open('/home/will/top-1m.csv')]

    sub_map = defaultdict(list)

    max_url_length = max(len(u) for u in urls)
    print "Max url length:", max_url_length

    def gen_subs():
        for i, url in enumerate(urls[:1000]):
            for sub in url.split('.'):
                if sub not in IGNORE_TLDS:
                    yield i+1, url, sub

    for pk, url, sub in gen_subs():

        for i in xrange(len(sub)):

            for n in xrange(i):

                search_sub = sub[n:n+i+1]

                sub_map[search_sub].append((0 if url.startswith(sub) else 1, pk))

                #print "\t", sub_word

    #import pprint
    #pprint.pprint(sub_map)

    for sub, indices in sub_map.iteritems():
        print sub, ','.join(str(pk) for starts, pk in sorted(indices)[:10])




if __name__ == "__main__":
    process()
