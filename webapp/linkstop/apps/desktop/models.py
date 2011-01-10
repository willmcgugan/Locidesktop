from django.db import models
from django.contrib.auth.models import User
from django.conf import settings
from django.core.cache import cache

import random
import time

# Create your models here.

import simplejson as json
#import json

from linkstop.tools import JSONPropertyDescriptor
from linkstop import url_normalize, url_normalize_base

import os, os.path



try:
    import cPickle as pickle
except ImportError:
    import pickle


DESKTOP_CACHE_BUSTER = str(settings.DESKTOP_CACHE_BUSTER)

class Desktop(models.Model):

    owner = models.ForeignKey(User, null=False)
    name = models.CharField(max_length=30)
    slug = models.SlugField(max_length=30)
    uid = models.CharField(max_length=61, unique=True)

    date_created = models.DateTimeField(auto_now_add=True)
    date_modified = models.DateTimeField(auto_now_add=True, auto_now=True)

    searchable = models.BooleanField( "Searchable",
                                      default=True )

    private = models.BooleanField( "Private desktop",
                                   default=False )

    allow_comments = models.BooleanField( "Allow comments",
                                          default=True )

    definition_json = models.TextField( "desktop definition json",
                                        blank=True,
                                        null=True )

    settings_json = models.TextField( "Settings json",
                                      blank=True,
                                      null=True )

    definition = JSONPropertyDescriptor('definition_json')
    settings = JSONPropertyDescriptor('settings_json')

    allow_rating = models.BooleanField("Allow ratings?",
                                       default=False)

    rating = models.IntegerField(default=0)
    num_ratings = models.IntegerField(default=0)

    restricted_content = models.BooleanField( "Restricted content?",
                                              default=False)
    restricted_content_type = models.IntegerField(blank=True, null=True, default=0)

    theme = models.ForeignKey('Theme', blank=True, null=True)

    def __unicode__(self):
        return "%s (%s's desktop)" % (self.name, self.owner.username)
    

    def get_absolute_url(self):
        if self.name == 'default':
            return '/%s/' % self.owner.username
        else:
            return '/%s/%s/' % (self.owner.username, self.slug)

    def desktop_link(self):
        url = self.get_absolute_url()
        return '''<a href="%s">%s</a>''' % (url, url)
    desktop_link.allow_tags = True


    def get_edit_url(self):
        return '/%s/%s/edit/' % (self.owner.username, self.slug)


    @classmethod
    def get_desktop_url(cls, username, desktop_slug):
        if desktop_slug == 'default':
            url = '/%s/' % username
        else:
            url = '/%s/%s/' % (username, desktop_slug)
        return url

    @classmethod
    def get_desktop_links(cls, user, exclude_private=False):

        username = user.username
        desktops = Desktop.objects.filter(owner=user)

        if exclude_private:
            desktops = desktops.exclude(private=True)

        def add_link(dt):
            if dt['slug'] == 'default':
                dt['url'] = '/%s/' % (username)
            else:
                dt['url'] = '/%s/%s/' % (username, dt['slug'])
            return dt

        desktop_list = [add_link(dt) for dt in desktops.values('name', 'slug', 'private')]
        desktop_list.sort(key = lambda d:d['slug'])
        return desktop_list

    @classmethod
    def create_default_desktop(cls, user):

        desktop, desktop_created =\
            Desktop.objects.get_or_create(owner=user,
                                          name='default',
                                          slug='default',
                                          uid='%s.%s'%(user.username, 'default'))

        return desktop

    @classmethod
    def update_revision_id(cls, owner_username, desktop_slug):
        key = 'dtoprevid.%s.%s~%s' % (owner_username, desktop_slug, DESKTOP_CACHE_BUSTER)
        rev_id = str(random.random())+str(time.time())
        cache.set(key, rev_id, 60*60*24*10)
        return rev_id

    @classmethod
    def delete_revision_id(cls, owner_username, desktop_slug):
        key = 'dtoprevid.%s.%s' % (owner_username, desktop_slug)
        cache.delete(key)

    @classmethod
    def get_revision_id(cls, owner_username, desktop_slug):
        key = 'dtoprevid.%s.%s~%s' % (owner_username, desktop_slug, DESKTOP_CACHE_BUSTER)
        rev_id = cache.get(key, None)
        if rev_id is None:
            return cls.update_revision_id(owner_username, desktop_slug)
        return rev_id

    def get_average_rating(self):
        """ Returns the average user rating for this desktop. """
        if not self.num_ratings:
            return 0
        return self.rating / float(self.num_ratings)

    def has_rated(self, user):
        """ Returns True if the user has rated this desktop. """
        return DesktopRating.objects.filter(user=user, desktop=self).count() > 0

    def rate(self, user, rating):
        """ Creates a new rating for a given desktop and user, or creates a new one. """
        try:
            # Look for an existing rating
            d_rating = DesktopRating.objects.get(user=user, desktop=self)
            # Subtract previous rating that we are removing
            self.rating -= d_rating.rating
            self.num_ratings -= 1
        except DesktopRating.DoesNotExist:
            d_rating = DesktopRating(user=user, desktop=self)

        d_rating.rating = rating
        self.rating += rating
        self.num_ratings += 1

        self.save()
        d_rating.save()

        return self.rating / float(self.num_ratings)



class IconCatalog(models.Model):

    name = models.CharField(max_length=30, null=False)
    description = models.TextField(null=False, blank=True, default="")
    copyright = models.TextField(null=False, blank=True, default="")

    priority = models.IntegerField(null=False, blank=False, default=100)

    visible = models.BooleanField(null=False, blank=True, default=True)

    def __unicode__(self):
        return self.name

    class Meta:
        ordering = ("name",)

    def get_categories(self):
        """ Returns a sorted list of the categories in the catalog. """
        return sorted(set(c[0] for c in self.icon_set.all().values_list('category')))

    def get_preview_url(self, category):
        filename = '%s.%s.jpg' % (self.name, category)
        return os.path.join(settings.MEDIA_URL, 'iconsetpreviews', filename).replace('\\', '/')
        #return '/'.join((settings.MEDIA_URL, 'iconsetpreviews', filename)).replace('//', '/')


class Icon(models.Model):

    catalog = models.ForeignKey('IconCatalog', null=False)

    category = models.CharField(max_length=30, null=False)
    name = models.CharField(max_length=30, null=False, blank=False)
    img_url = models.CharField('Image url', max_length=200, null=False, blank=False)
    path = models.CharField('Image path', max_length=200, null=False, blank=False)
    sizes = models.CharField("Available sizes", max_length=128)

    def get_icon_html(self, size=64):
        icon_url = self.img_url.replace('[SIZE]', str(size))
        icon_url = os.path.join(settings.MEDIA_URL, icon_url)
        return '<img style="border:1px solid #999;margin:2px;" src="%s">' % icon_url.replace('.png', '.jpg')
    get_icon_html.allow_tags = True


    def get_icons_html(self):
        return "".join(self.get_icon_html(size) for size in self.get_sizes())
    get_icons_html.allow_tags = True

    def get_key(self):
        return "%s.%s.%s" % (self.catalog.name, self.category, self.name)

    def get_sizes(self):
        return map(int, self.sizes.split(','))


    def __unicode__(self):
        return self.name

    class Meta:
        ordering = ("name",)

    @classmethod
    def lookup(cls, icon_key):
        try:
            iconcatalog, category, name = icon_key.split('.')
        except ValueError:
            raise ValueError, "Icon key consist of <catalog name>.<category>.<icon name>"
        catalog = IconCatalog.objects.get(name=iconcatalog)
        icon = catalog.icon_set.get(category=category, name=name)
        return icon


class FavIcon(models.Model):

    url = models.CharField(max_length=200, null=False)

    normalized_url = models.CharField(unique=True, db_index = True, max_length=200, null=False)
    normalized_base_url = models.CharField(db_index = True, max_length=100, null=False)

    sizes = models.CharField(max_length=128, null=False)
    original_sizes = models.CharField(max_length=128, null=False)
    rendered = models.BooleanField(default=False, blank=True, null=False)
    date_modified = models.DateTimeField(auto_now_add=True, auto_now=True)


    def update(self):
        url = self.url
        self.normalized_url = url_normalize(url)
        self.normalized_base_url = url_normalize_base(url)

    def get_sizes(self):
        return [int(s) for s in self.sizes.split(',') if s]

    def merge_sizes(self, sizes):
        self.sizes = ','.join(str(s) for s in sorted(set(self.get_sizes() + sizes)))

    def get_original_sizes(self):
        return [int(s) for s in self.original_sizes.split(',') if s]

    def __unicode__(self):
        return "%s retrieved on %s" % (self.normalized_url, self.date_modified)

    class Meta:
        ordering = ('normalized_url',)

    def get_icon_html(self, size=64):
        from linkstop import get_favicon_size_url
        url = get_favicon_size_url(self.normalized_url, size)
        return '<img style="border:1px solid #999;margin:2px;" src="%s">' % url
    get_icon_html.allow_tags = True


    def get_icons_html(self):
        return "".join(self.get_icon_html(size) for size in self.get_sizes())
    get_icons_html.allow_tags = True


    def mark_for_render(self):
        self.rendered = False
        self.sizes = self.original_sizes
        self.save()

    def export(self, out_file):
        export_dict = dict( url = self.url,
                            normalized_url = self.normalized_url,
                            normalized_base_url = self.normalized_base_url,
                            sizes = self.sizes,
                            original_sizes = self.sizes,
                            rendered = self.rendered,
                            date_modified = self.date_modified )

        pickle.dump(export_dict, out_file)

    @classmethod
    def import_(self, in_file):

        try:
            import_dict = pickle.load(in_file)
        except:
            return None, None

        normalized_url = import_dict.pop('normalized_url')

        favicon, created = FavIcon.objects.get_or_create( normalized_url=normalized_url,
                                                 defaults = import_dict)
        if not created:
            for k, v in import_dict.iteritems():
                setattr(favicon, k, v)
            favicon.save()
        return favicon, created


class Resource(models.Model):

    name = models.CharField(max_length=100, null=False, blank=False)
    slug = models.SlugField(max_length=100, null=False, blank=False)
    url = models.CharField(max_length=200, null=False, blank=True)
    normalized_url = models.CharField(max_length=200)
    search_url = models.CharField(max_length=200, null=True, blank=True)

    extra_query = models.CharField("Extra query to add to urls",
                                   max_length=200,
                                   null=True,
                                   blank=True)

    description = models.TextField("A brief description of the resource")
    notes = models.TextField("A description of the resource")

    icon = models.ForeignKey(Icon, null=True, blank=True)

    def get_url(self):
        if ':' in self.url:
            return self.url
        return 'http://' + self.url

    def get_search_url(self):
        if ':' in self.search_url:
            return self.search_url
        return 'http://' + self.search_url

    def __unicode__(self):
        return self.name

    class Meta:
        ordering = ('name',)

class AutoUrl(models.Model):
    rank = models.IntegerField(primary_key=True, null=False)
    url = models.CharField(null=False, max_length=80)
    adult = models.BooleanField(default=False)

    def __unicode__(self):
        return self.url

    class Meta:
        ordering = ('url',)


class SubUrlSearch(models.Model):
    sub = models.CharField(primary_key=True, null=False, max_length=80)
    pks = models.CharField(max_length=80, null=False)
    
    def __unicode__(self):
        return self.sub


class DesktopRating(models.Model):
    user = models.ForeignKey(User)
    desktop = models.ForeignKey(Desktop)
    rating = models.IntegerField(default=0)
    
class Theme(models.Model):
    
    date_created = models.DateTimeField(auto_now_add=True)
    date_modified = models.DateTimeField(auto_now=True)
    
    owner = models.ForeignKey(User, null=True, blank=True)
    slug = models.SlugField(max_length=100, null=False, blank=False)
    name = models.CharField(max_length=100, null=False, blank=False)
    approved = models.BooleanField(default=False)
    
    description = models.TextField(default='', blank=True)
    css = models.TextField(default='', blank=True)
    html = models.TextField(default='', blank=True)
    js = models.TextField(default='', blank=True)
    
    def __unicode__(self):
        return self.name
    
    
CLIP_CHOICES = ( (0, 'icon'), )
    
    
class Clip(models.Model):
    
    owner = models.ForeignKey(User, null=False, blank=False)
    desktop = models.ForeignKey(Desktop, null=True, blank=True)
    date_created = models.DateTimeField(auto_now_add=True)
    clip_type = models.IntegerField(default=0, blank=True)
    count = models.IntegerField(default=1)
    
    clip_json = models.TextField(default='', blank=True)
    clip = JSONPropertyDescriptor('clip_json')
    
    def __unicode__(self):
        text = u'%i %s' % (self.count, self.get_clip_type_display())
        if self.count > 1:
            text += 's'
        if self.desktop:
            text += u' in %s' % unicode(self.uid)
        return text
        
