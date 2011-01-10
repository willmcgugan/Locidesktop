import simplejson as json
from django.conf import settings
from django.http import HttpResponse
from django.conf.urls.defaults import *
from django.contrib.auth import authenticate, login, logout
from django.core.urlresolvers import reverse
from django.core.cache import cache
from django.db import IntegrityError
import apiversion

from pprint import pprint
from datetime import datetime
import time
import traceback
from functools import wraps
import inspect
from hashlib import md5
from itertools import *

from linkstop import *
from linkstop.apps.desktop.models import *
from linkstop.urls import is_reserved_path
from linkstop.apps.desktop.signals import desktop_changed, user_desktops_changed
from linkstop.tools import slugify
from linkstop import url_normalize as favicon_url_normalize
from itertools import chain, izip, takewhile

IGNORE_TLDS = frozenset(['com', 'co.uk', 'net', 'org'])


CACHE_BUSTER = str(settings.CACHE_BUSTER)


class APIError(Exception):
    def __init__(self, error="", msg=""):
        self.error = error or "error"
        self.msg = msg or ""
    def __unicode__(self):
        return "%s (%s)" % (self.error, self.msg)

class Result(dict):
    def __init__(self, result='success', *args, **kwargs):
        self['result'] = result
        dict.__init__(self, *args, **kwargs)

    def success(self):
        return self.get('result', '') == 'success'

class Fail(Result):
    def __init__(self, *args, **kwargs):
        Result.__init__(self, 'fail', *args, **kwargs)

def API(f):

    name = f.__name__

    @wraps(f)
    def deco(cls, request, *args, **kwargs):

        cache_seconds = None
        data = {}
        data['apimethod'] = name
        data['callback'] = request.GET.get('callback')
        try:
            if getattr(f, '_auth_not_required', False):
                if request.is_anonymous():
                    raise APIError("authrequired",
                                   "A login is required for this method")

            get_param = request.REQUEST.get
            REQUEST = request.REQUEST
            defaults = f._defaults
            try:
                def param_default(i, arg):
                    p = get_param(arg)
                    if p is None:
                        return defaults[i+1]
                    return p
                params = [param_default(i, arg) for i, arg in enumerate(f._args[1:])]
            except KeyError:
                raise APIError('missingparameter',
                               'A required parameter was not supplied')

            start_time = time.time()

            ret = None
            cache_seconds = getattr(f, '_cache_seconds', 0)
            if cache_seconds:
                cache_key = f._cache_key_gen(request, *params)
                data['cache_key'] = cache_key
                cached_data = cache.get(cache_key)
                if cached_data is not None:
                    ret = cached_data

            if ret is None:
                ret = f(request, *params) or Result()
                if cache_seconds:
                    cache.set(cache_key, ret, cache_seconds)

            end_time = time.time()

        except APIError, e:
            data['status'] = 'error'
            data['error'] = e.error
            data['error_msg'] = e.msg
        except Exception, e:
            data['status'] = 'fail'
            data['error'] = 'exception'
            data['error_msg'] = str(e)
            if settings.DESKTOP_API_DEBUG:
                data['exception'] = traceback.format_exc().split('\n')
        else:
            if isinstance(ret, HttpResponse):
                return ret
            data['status'] = 'ok'
            data['response'] = ret
            if settings.DESKTOP_API_DEBUG:
                data['timetaken'] = "%.2f ms" % ((end_time - start_time) * 1000.)

        data['call_id'] = request.REQUEST.get('call_id');

        if settings.DESKTOP_API_DEBUG:
            pprint(data)
            time.sleep(.5)


        json_reply = json.dumps(data, indent=4 if settings.DESKTOP_API_DEBUG else 0)


        return HttpResponse(json_reply, mimetype='application/javascript')


    argspec = inspect.getargspec(f)

    args, varargs, keywords, defaults = argspec
    #args = argspec.args
    f._args = args
    defaults = defaults or ()
    default_start = len(args)-len(defaults)
    f._defaults = dict( zip( xrange(default_start, default_start+len(args)), defaults ) )

    deco.is_api_view = True
    return deco


def cache_api(days=None, hours=None, minutes=None, seconds=None, cache_key_gen=None):

    """ Enables simple caching on the api call. """

    cache_seconds = 0
    if seconds is not None:
        cache_seconds += seconds
    if minutes is not None:
        cache_seconds += minutes * 60
    if hours is not None:
        cache_seconds += hours * 60 * 60
    if days is not None:
        cache_seconds += days * 24 * 60 * 60

    def deco(f):
        def simple_cache_key(request, *params):
            cache_key = u'api.%s.%s~%s' % (f.__name__, '.'.join(map(unicode, params)), CACHE_BUSTER)
            if len(cache_key) >= 250:
                cache_key = u'api.' + md5(cache_key).hexdigest()
            return cache_key

        f._cache_seconds = cache_seconds
        f._cache_key_gen = cache_key_gen or simple_cache_key
        return f

    return deco


def auth_not_required(f):
    f._auth_not_required = True
    return f

class APIViews(object):

    def __init__(self):
        methods = self.__class__.__dict__.items()
        self._views = [name for (name, f) in methods if getattr(f, 'is_api_view', False)]

        def make_url(view_name):
            return url(r'^%s/'%view_name,
                       getattr(self, view_name),
                       name='api_'+view_name)

        urls = tuple(make_url(view_name) for view_name in self._views)
        self._patterns = patterns( '', *urls )


class DesktopAPI(APIViews):


    @classmethod
    def permission_to_edit(user, desktop):
        if user.is_staff:
            return True
        return desktop.user == user

    @classmethod
    def get_desktop(cls, user, slug):
        """ Retrives a given desktop """
        try:
            desktop = Desktop.objects.get(owner__id=user.id, slug=slug)
        except Desktop.DoesNotExist:
            raise APIError('nodesktop', 'No such desktop')

    @classmethod
    def make_desktop_key(cls, username, desktop_slug):
        """ Generate a unique key for a username and desktop """
        return 'desktop.'+Desktop.get_revision_id(username, desktop_slug)
        #return "desktop.%s.%s" % (username, desktop_slug)

    #@classmethod
    #def get_desktop_hash(cls, username, slug):
    #    return md5(make_desktop_key(username, slug)).hexdigest()

    #@classmethod
    #def get_desktop_hash_path(cls, username, slug):
    #    desktop_hash = get_desktop_hash(username, slug)
    #    return "/".join(desktop_hash[i:i+2] for i in range(0,len(desktop_hash),2))

    @classmethod
    def get_desktop_definition(cls, username, desktop_slug):
        """ Retrieves a (potentially cached) desktop definition """
        cached_definition = cls.get_desktop_cache(username, desktop_slug)
        if cached_definition is not None:
            return cached_definition
        try:
            return Desktop.objects.filter(owner__username=username, slug=desktop_slug)\
                .values_list('definition_json')[0][0]
        except (Desktop.DoesNotExist, IndexError):
            raise APIError('nodesktop', 'No such desktop')

    @classmethod
    def set_desktop_definition(cls, username, desktop_slug, definition_json):
        """ Sets a desktop definition, invalidates the cache and emits a signal. """
        num_rows = Desktop.objects.filter(owner__username=username, slug=desktop_slug)\
            .update(definition_json=definition_json, date_modified=datetime.now())
        if not num_rows:
            raise APIError('nodesktop', 'No such desktop')
        assert num_rows <= 1, "More than one row set by set_desktop_definition"
        cls.set_desktop_cache(username, desktop_slug, definition_json)
        desktop_changed.send(sender=cls, username=username, desktop_slug=desktop_slug)

    @classmethod
    def clear_desktop_cache(cls, username, desktop_slug):
        """ Clears a desktop definition """
        cache_key = cls.make_desktop_key(username, desktop_slug)
        cache.delete(cache_key)

    @classmethod
    def set_desktop_cache(cls, username, desktop_slug, definition_json):
        """ Caches a desktop definition """
        cache_key = cls.make_desktop_key(username, desktop_slug)
        cache.set(cache_key, definition_json)

    @classmethod
    def get_desktop_cache(cls, username, desktop_slug):
        """ Retrieves a desktop definition, if it exists, otherwise None. """
        cache_key = cls.make_desktop_key(username, desktop_slug)
        return cache.get(cache_key, None)

    @API
    def extest(request):
        1/0

    @API
    def ertest(request):
        raise APIError("test", "A test error")

    @API
    @auth_not_required
    def get_version(request):
        """ Returns the API version. """
        return Result(version=apiversion.VERSION)

    @API
    @auth_not_required
    def ping(request, ping='pong'):
        """ Simple ping request. """
        return Result(pong=ping)

    @API
    @auth_not_required
    def login(request, username, password):
        """ Attempts a login. """
        user = authenticate(username=username, password=password)
        if user is None:
            return Result("noauth")
        login(request, user)
        settings = Profile.objects.filter(user__pk=request.user.pk)\
            .values_list('settings_json')[0][0]
        return Result(settings=settings)

    @API
    @auth_not_required
    def get_login(request):
        """ Returns the username of the currently logged in user, or a blank
        string if the user is anonymous. """
        user = request.user
        return Result(username='' if user.is_anonymous() else user.username)

    @API
    @auth_not_required
    def logout(request):
        """ Just logs out. """
        logout(request)

    @API
    def get_settings(request):
        """ Retrieves the settings json for the currently logged in user. """
        return Profile.objects.filter(user__pk=request.user.pk)\
            .values_list('settings_json')[0][0]

    @API
    def set_settings(request):
        """ Sets the settings json for the currently logged in user. """
        settings = request.REQUEST.get('settings')
        Profile.objects.filter(user__pk=request.user.pk).update(settings_json=settings)
        user_desktops_changed.send(sender=DesktopAPI, username=request.user.username)


    @API
    @auth_not_required
    def check_username(request):
        """ Checks if a username exists. """
        try:
            User.objects.get(username=request.REQUEST[username])
        except User.DoesNotExist:
            return Result(available=not is_reserved_path(username+'/'))
        else:
            return Result(available=False)

    @API
    @auth_not_required
    def create_account(request):
        """ Creates a new account. """

        get = request.REQUEST.get
        username = get('username')
        password = get('password')
        email = get('email')

        if is_reserved_path(username+'/'):
            raise APIError('usernamereserved', "Username is reserved")

        try:
            new_user = User.objects.create( username = username,
                                            password = password,
                                            email = email )
        except:
            # TODO: Catch specific exceptions
            raise APIError('usernameexists', "Username exists")
        else:
            new_profile = Profile.objects.create(user = new_user)
            user = authenticate(username=username, password=password)
            assert user.pk == new_user.pk, "Authenticated user is not the new user"
            login(request, user)

    @API
    def create_desktop(request, desktop_name, private):
        slug = slugify(desktop_name)
        if not slug:
            return Result('fail', message='Invalid characters in desktop name.')

        num_desktops = Desktop.objects.filter(owner=request.user).count()

        if num_desktops >= 10:
            return Result('fail', message="Sorry, there is currently a limit of 10 desktops per user.")

        user = request.user
        uid = u'%s.%s' % (user.username, slug)

        private = private != 'false';

        try:
            desktop = Desktop.objects.create(   owner=user,
                                                name=desktop_name,
                                                slug=slug,
                                                uid=uid,
                                                private=private )
        except IntegrityError:
            return Result('fail', message='You already have a desktop of this name.')

        user_desktops_changed.send(sender=DesktopAPI, username=user.username)

        return Result('success',
                      slug=slug,
                      username=user.username,
                      url=desktop.get_edit_url())


    @API
    def get_desktop(request, username, desktop):
        """ Retrieves the definition json for a given desktop. """

        desktop_obj = Desktop.objects.filter( owner__username=username,
                                              slug=desktop).values('private')[0]
        if desktop_obj['private'] and not request.user.is_staff:
            raise APIError('nopermission', "You don't have permission to access this private desktop")

        definition = DesktopAPI.get_desktop_definition(username, desktop)
        return Result(definition=definition)

    @API
    def set_desktop(request, username, desktop, definition):
        """ Sets the definition url for a given desktop. """

        if username == 'test':
            return Result('fail', msg="Sorry, save is disabled for this account.")

        if username == 'new':
            username = request.user.username

        if request.user.username != username and not request.user.is_staff:
            raise APIError('nopermission',
                           "You aren't the owner of this desktop and can not make changes")

        DesktopAPI.set_desktop_definition(username, desktop, definition)

    @API
    def set_new_desktop(request, definition):
        request.session['new_desktop_definition'] = definition


    @API
    def delete_desktop(request, username, desktop_slug):

        if desktop_slug == 'default':
            return Result('fail',
                          message="Sorry, you may not delete the default desktop.")
        if request.user.username=='test':
            return Result('fail',
                          mesage="Sorry, you can not delete desktops for this account.")

        if request.user.username != username and not request.user.is_staff:
            return Result('nopermission',
                          message="You must be the owner of the desktop to delete it")

        user_desktops_changed.send(sender=DesktopAPI, username=username)
        Desktop.objects.filter(owner=request.user, slug=desktop_slug).delete()
        url = '/' + request.user.username + '/'

        return Result('success', message='Desktop was deleted successfuly.', url=url)


    @API
    def rename_desktop(request, username, desktop_slug, new_name):
        new_slug = slugify(new_name)
        if Desktop.objects.filter(owner__username=username, slug=new_slug).count():
            return Result('fail', message="Can't rename this desktop, a desktop of that name already exists.")
        if not new_slug:
            return Result('fail', message="Invalid name. Desktop was not renamed.")
        if len(new_slug) >= 30:
            return Result('fail', message="Name is too long (must be less that 30 characters)")
        if request.user.username != username and not request.user.is_staff:
            return Result('nopermission',
                          message="You must be the owner of the desktop to rename it")
        user_desktops_changed.send(sender=DesktopAPI, username=username)
        desktop = Desktop.objects.get(owner__username=username, slug=desktop_slug)
        desktop.name = new_name
        desktop.slug = new_slug
        desktop.save()
        #user_desktops_changed.send(sender=DesktopAPI, username=username)
        return Result(url=desktop.get_absolute_url())

    VALID_DESKTOP_SETTINGS = dict(private = bool)

    @API
    def set_desktop_setting(request, username, desktop_slug, key, value):

        if request.user.username != username and not request.user.is_staff:
            raise APIError('nopermission',
                           "You aren't the owner of this desktop and can not make changes")

        if request.user.username == 'test':
            return Result('fail', msg="Sorry, you can not change settings for this desktop.")

        if key not in DesktopAPI.VALID_DESKTOP_SETTINGS:
            raise APIError("invalidsetting",
                           "Setting does not exist, or you have no permission")

        value_type = DesktopAPI.VALID_DESKTOP_SETTINGS[key]

        if value_type == bool:
            value = value.lower() in ('1', 'true')

        key = str(key)

        if key == 'private' and desktop_slug == "default":
            return Result( "fail", key=key, value=value,
                           message="Sorry, you can't make your default desktop private")

        if not Desktop.objects.filter(owner__username=username, slug=desktop_slug).update(**{key:value}):
            return Result('fail', key=key, value=value, message="Could not find desktop")

        desktop_changed.send(sender=None, username=username, desktop_slug=desktop_slug)
        user_desktops_changed.send(sender=DesktopAPI, username=username)

        return Result('success', key=key, value=value)

    @API
    @cache_api(hours=24)
    def lookup_url(request, url, maxitems=10):

        url = url.strip().lower()[:100]

        if ':' in url:
            url = url.split(':', 1)[-1].lstrip('/')

        search_url = url

        www = url.startswith('www.') and len(url) > 4
        if www:
            url = url[4:]

        found_urls = []

        for term in url.split('.'):
            if '.' in url and term in IGNORE_TLDS:
                continue
            try:
                sub_url = SubUrlSearch.objects.get(sub=term)
            except SubUrlSearch.DoesNotExist:
                continue
            else:
                pks = [int(rank) for rank in sub_url.pks.split(',')]

                urls = list(AutoUrl.objects.filter(rank__in=pks).values_list('rank', 'url'))

                found_urls += urls

        found_urls.sort(key=lambda u:(not u[1].startswith(url), int(u[0]), u[1]))

        if www:
            found_urls = [u'www.'+u[1] if not u[1].startswith('www')
                            else u[1] for u in found_urls[:maxitems]]
        else:
            found_urls = [u[1] for u in found_urls[:maxitems]]

        return Result(search_url=search_url, urls=found_urls)


    @API
    @cache_api(hours=24)
    def get_one_char_lookups(request):

        one_chars = {}
        for sub_url in SubUrlSearch.objects.filter(sub__in="abcdefghijklmnopqrstuvwxyz1234567890"):

            pks = [int(rank) for rank in sub_url.pks.split(',')]
            urls = list(AutoUrl.objects.filter(rank__in=pks).values_list('rank', 'url'))

            urls.sort(key=lambda u:(not u[1].startswith(sub_url.sub), int(u[0]), u[1]))
            one_chars[sub_url.sub] = [u[1] for u in urls]

        return Result(one_char_urls = one_chars)


    @API
    def refresh_icons(request, urls):

        urls = map(None, urls.split('|'))
        original_urls = urls
        urls = [url_normalize(url) for url in urls if url]

        def get_sizes(sizes):
            return [int(s) for s in sizes.split(',')]

        favicons = FavIcon.objects.filter(normalized_url__in=urls).distinct().values_list('url', 'sizes')
        favicon_lookup = dict((k, get_sizes(v)) for k, v in favicons)

        normalized_base_urls = [url_normalize_base(url) for url in urls]
        favicons = FavIcon.objects.filter(normalized_url__in=normalized_base_urls).distinct().values_list('url', 'sizes')
        normalized_favicon_lookup = dict((url_normalize_base(k),get_sizes(v)) for k,v in favicons)


        def get_favicon_url(url):

            normalized_url = url_normalize(url)
            if normalized_url in favicon_lookup:
                url = get_favicon_size_url(normalized_url, '[SIZE]')
                sizes = favicon_lookup[normalized_url]
                return url, sizes

            normalized_url = url_normalize_base(url)
            if normalized_url in normalized_favicon_lookup:
                url = get_favicon_size_url(normalized_url, '[SIZE]')
                sizes = normalized_favicon_lookup[normalized_url]
                return url, sizes

            return None, None

        icon_favicons = {}
        for url, original_url in izip(urls, original_urls):
            favicon_url, sizes = get_favicon_url(url)
            if favicon_url is not None:
                icon_favicons[original_url] = dict( favicon_img_url_template=favicon_url,
                                                    favicon_sizes=sizes)

        return Result(favicons=icon_favicons)


    @API
    def add_icons(request, urls):
        """ Retrieves a list of icons for the given urls. """

        default_icon = Icon.lookup(settings.DEFAULT_ICON)

        def name_from_url(url):
            url = url.lstrip('/').split('/', 1)[0]
            endswith = url.endswith
            for tld in ('.com', '.org', '.co.uk', '.net'):
                if endswith(tld):
                    url = url[:-len(tld)]
                    break
            if url.lower().startswith('www.'):
                url = url[4:]
            return url.title()

        icons = []
        urls = urls.split('|')

        urls = [url_normalize(url) for url in urls]

        found_resources = Resource.objects.filter(normalized_url__in=urls)
        found_urls = set(r.normalized_url for r in found_resources)
        not_found_urls = set(urls) - found_urls

        def get_sizes(sizes):
            return [int(s) for s in sizes.split(',')]

        favicons = FavIcon.objects.filter(normalized_url__in=urls).distinct().values_list('url', 'sizes')
        favicon_lookup = dict((k, get_sizes(v)) for k, v in favicons)


        normalized_base_urls = [url_normalize_base(url) for url in urls]
        favicons = FavIcon.objects.filter(normalized_url__in=normalized_base_urls).distinct().values_list('url', 'sizes')
        normalized_favicon_lookup = dict((url_normalize_base(k),get_sizes(v)) for k,v in favicons)


        def get_favicon_url(url):

            normalized_url = url_normalize(url)
            if normalized_url in favicon_lookup:
                url = get_favicon_size_url(normalized_url, '[SIZE]')
                sizes = favicon_lookup[normalized_url]
                return url, sizes

            normalized_url = url_normalize_base(url)
            if normalized_url in normalized_favicon_lookup:
                url = get_favicon_size_url(normalized_url, '[SIZE]')
                sizes = normalized_favicon_lookup[normalized_url]
                return url, sizes

            return None, None

        img_prefix = settings.MEDIA_URL

        def prefix(url):
            if '://' in url:
                return url
            return img_prefix + url.lstrip('/')

        def check_size(sizes):
            size = settings.DEFAULT_ICON_SIZE
            if size in sizes:
                return size
            if not sizes:
                return 16
            return sizes[-1]

        for resource in found_resources:
            icon = dict(    use_favicon =      False,
                            visible =          True,
                            name =             resource.name,
                            type =             'icon',
                            url =              resource.get_url(),
                            search_url =       resource.get_search_url(),
                            icon_key =         resource.icon.get_key(),
                            extra_query =      resource.extra_query,
                            description =      resource.description,
                            notes =            resource.notes,
                            img_url_template = prefix(resource.icon.img_url),
                            icon_sizes =       resource.icon.get_sizes() )

            icons.append(icon)

        for url in not_found_urls:
            icon = dict(    use_favicon =      True,
                            visible =          True,
                            name =             name_from_url(url),
                            type =             'icon',
                            url =              u'http://'+url,
                            search_url =       '',
                            icon_key =         settings.DEFAULT_ICON,
                            img_url_template = prefix(default_icon.img_url),
                            icon_sizes =       default_icon.get_sizes() )

            icons.append(icon)

        for icon in icons:

            normalized_url = favicon_url_normalize(icon['url'])

            icon['has_favicon'] = False
            icon['custom_img_url_template'] = icon['img_url_template']
            icon['custom_sizes'] = icon['icon_sizes']

            icon['normalized_url'] = normalized_url
            fav_url, fav_sizes = get_favicon_url(icon['url'])
            if fav_url:
                icon['has_favicon'] = True
                icon['favicon_img_url_template'] = fav_url
                icon['favicon_sizes'] = fav_sizes

            icon['use_favicon'] = icon['has_favicon'] and icon['use_favicon']

            if icon['use_favicon']:
                icon['icon_size'] = check_size(icon['favicon_sizes'])

            else:
                icon['icon_size'] = check_size(icon['icon_sizes'])


        return Result(icons=icons)

    @API
    @cache_api(hours=1)
    def list_icon_catalogs(request):
        """ Returns a list of available icon catalogs, sorted by priority then name """

        catalogs = IconCatalog.objects.all().order_by('priority', 'name')

        def get_categories(catalog):
            return sorted(set(c[0] for c in catalog.icon_set.all().values_list('category')))

        catalogs_list = [(catalog.name, get_categories(catalog)) for catalog in catalogs]

        return catalogs_list


    @API
    @cache_api(hours=1)
    def get_icon_catalog(request, name):
        """ Retrieves an icon catalog that consists of list of dictionaries
        contain the category, icon name and url.

        """

        catalog_name, category_name = name.split('.')

        try:
            catalog = IconCatalog.objects.get(name=catalog_name)
        except IconCatalog.DoesNotExist:
            raise APIError('noiconcatalog', "No icon catalog with name '%s'" % name)

        def make_icon(i):
            i['sizes'] = map(int, i['sizes'].split(','))
            url = i['img_url']
            img_prefix = settings.MEDIA_URL
            if ':' not in url:
                url = img_prefix + url.lstrip('/')
            i['img_url'] = url
            return i

        icons = [make_icon(i) for i in catalog.icon_set
                    .filter(category=category_name).values('name', 'img_url', 'sizes')]


        return dict( icon_catalog=name,
                     icons=icons,
                     preview_url = catalog.get_preview_url(category_name) )

    @API
    def get_desktops_for_user(request, username):
        """ Retrieves a list of a users desktops. """
        user = User.objects.get(username=username)
        desktops = Desktop.get_desktop_links(user, private=not user.is_anonymous())
        return dict(desktops=desktops)

    @API
    def rate(request, desktop_slug, rating):
        """ Rates a desktop, and returns the new rating. """
        if rating < 0 or rating > 100:
            raise ValueError("Rating must be within the range 0->100 (inclusive)")
        desktop = Desktop.objects.get(owner=request.user, desktop_slug=desktop_slug)
        new_rating = desktop.rate(request.user, rating)
        return dict(    total_rating=desktop.rating,
                        average_rating=average_rating,
                        num_ratings=desktop.num_ratings)


    @classmethod
    def _get_favicon(cls, url, size):

        cache_key = 'getfavicon.%s.%s~%s' % (url, size, CACHE_BUSTER)
        cached = cache.get(cache_key)
        if cached is not None:
            return cached

        size = 16 if size is None else int(size)
        norm_url = url_normalize(url)
        favicon = None
        try:
            favicon = FavIcon.objects.get(normalized_url=norm_url)
        except FavIcon.DoesNotExist:
            pass

        if favicon is None:
            norm_url = url_normalize_base(url)
            try:
                favicon = FavIcon.objects.filter(normalized_base_url=norm_url)[0]
            except IndexError:
                pass


        if favicon is None:
            return None

        if size not in favicon.get_sizes():
            for s in takewhile(lambda s:s<size, favicon.get_sizes()):
                pass
            size = s

        result = dict( url=url,
                       icon_url=get_favicon_size_url(norm_url, size))

        cache.set(cache_key, result, 60*60*24)
        return result



    @API
    @cache_api(hours=7)
    def get_favicon(request, url, size=None):

        size = 16 if size is None else int(size)
        norm_url = url_normalize(url)
        favicon = None
        try:
            favicon = FavIcon.objects.get(normalized_url=norm_url)
        except FavIcon.DoesNotExist:
            pass

        if favicon is None:
            norm_url = url_normalize_base(url)
            try:
                favicon = FavIcon.objects.filter(normalized_base_url=norm_url)[0]
            except IndexError:
                pass

        if favicon is None:
            return Result('notfound', url=url)

        if size not in favicon.get_sizes():
            for s in favicon.get_sizes():
                if s > size:
                    break;
                size = s
            else:
                size = favicon.get_sizes()[0]

        if size in favicon.get_sizes():
            return Result( 'found',
                           url=url,
                           icon_url=get_favicon_size_url(norm_url, size))

        else:
            return Result('notfound', url=url)


    @API
    @cache_api(hours=1)
    def get_favicons(request, urls, size=None):

        urls = [url for url in urls.split('|') if url]
        found_urls = []
        for url in urls:
            result = DesktopAPI._get_favicon(url, size)
            if result is not None:
                found_urls.append(result)

        return Result(urls=found_urls)


    @API
    @cache_api(days=7)
    def get_top_urls(request, start, count):
        start = int(start)
        count = int(count)
        urls = list(AutoUrl.objects.all().order_by('rank').values_list('url', flat=True)[start:start+count])
        return Result(urls=urls)

    @API
    def set_session_icons(request, urls):
        request.session["new_desktop_urls"] = urls.split('|');
        return Result(fwd_url=reverse('new_desktop'))

    @API
    def save_icons_clip(request, count, icons, desktop_slug):
        user = request.user
        desktop = Desktop.objects.get(owner=user, slug=desktop_slug)
        clip = Clip( owner = user,
                     desktop = desktop,
                     clip_type = 0,
                     count = count,
                     clip_json = icons)
        clip.save()
        return Result(id=clip.pk)

    @API
    def get_icons_clip_list(request, desktop_slug):
        user = request.user
        clip_values = ('id', 'count', 'date_created', 'clip_json')
        icons_list = list(Clip.objects.filter(owner=user, desktop__slug=desktop_slug)
            .order_by('date-created').values(*clip_values))
        return Result(clips=icons_list)

    @API
    def delete_icon_clip(request, clip_id):
        user = request.user
        try:
            clip = Clip.objects.get(pk=clip_id, owner=user)
        except Clip.DoesNotExist:
            return Result('fail')
        clip.delete()

    @API
    def set_icon(request, username, desktop_slug, icon_id, name, url, notes=''):

        desktop = Desktop.objects.get(owner__username=username, slug=desktop_slug)
        if desktop.owner != request.user and not request.user.is_staff:
            raise APIError('nopermission',
                           "You aren't the owner of this desktop and can not make changes")

        desktop_def = json.loads(desktop.definition_json)
        for icon in desktop_def['icons']:
            if icon['icon_id'] == icon_id:
                icon['name'] = name
                icon['url'] = url
                icon['notes'] = notes
                break
        desktop.definition_json = json.dumps(desktop_def)
        desktop.save()
        return Result(icon=icon)



the_api = DesktopAPI()

if __name__ == "__main__":
    print DesktopAPI.get_desktop_hash_path("will", "default")
