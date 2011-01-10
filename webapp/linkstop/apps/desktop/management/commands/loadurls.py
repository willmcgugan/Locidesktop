from __future__ import with_statement

from django.core.management.base import BaseCommand, CommandError
from linkstop.apps.desktop.models import *
from django.db.transaction import commit_on_success

from itertools import islice
from collections import defaultdict
import re

IGNORE_TLDS = frozenset(['.com', '.co.uk', '.net', '.org'])

class Command(BaseCommand):
    help = 'Loads topsites csv file (available from http://www.alexa.com/topsites)'
    args = "loadurls <filename> <max urls>"

    @commit_on_success
    def handle(self, *params, **options):

        if len(params) != 2:
            raise CommandError("Invalid number of parameters")
        filename, max_urls = params
        max_urls = int(max_urls)

        max_length = 0

        AutoUrl.objects.all().delete()
        create_url = AutoUrl.objects.create

        print "Storing auto urls"


        with open(filename) as f:
            for line in islice(f, max_urls):
                rank, _, url = line.strip().partition(',')
                create_url(url=url, rank=int(rank))


        sub_map = defaultdict(list)


        print "Generating sub map"

        SubUrlSearch.objects.all().delete()

        re_url_split = re.compile(r'[\.\/]')


        def gen_subs():
            with open(filename) as f:
                for i, line in enumerate(islice(f, max_urls)):
                    i, _, url = line.strip().partition(',')
                    for sub in re_url_split.split(url):
                        if sub not in IGNORE_TLDS:
                            yield int(i), url, sub.lower()

        for pk, url, sub in gen_subs():
            
            len_sub = len(sub)

            for size in xrange(len_sub):

                for search_sub in set(sub[start:start+size+1] for start in xrange(len_sub-size)):
                    
                    sub_list = sub_map[search_sub]                    
                    sub_list.append((0 if url.lower().startswith(sub) else 1, pk))
                    if len(sub_list) > 20:
                        sub_list.sort()
                        del sub_list[10:]

        print "Inserting suburlsearch objects"

        create = SubUrlSearch.objects.create

        for sub, indices in sub_map.iteritems():
            pks = ','.join(str(pk) for starts, pk in sorted(indices)[:10])
            #print sub, pks
            create(sub=sub, pks=pks)
