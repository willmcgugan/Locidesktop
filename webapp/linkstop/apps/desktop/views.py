from django.http import HttpResponse, HttpResponseRedirect, Http404
from django.shortcuts import get_object_or_404
from django.core.cache import cache
from django.views.decorators.http import etag
from django.db.models.signals import post_delete, post_save
from django.conf import settings
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib import auth

from linkstop.shortcuts import *
from linkstop.djangojinja2 import render_to_string, render_to_response
from django.template import TemplateDoesNotExist

import random
import simplejson as json
import time
from functools import partial

from linkstop.apps.desktop.models import *
from linkstop.apps.desktop.api.views import DesktopAPI, APIError
from linkstop.apps.desktop.signals import *

def possessive(n):
    return n + "'" if n.endswith('s') else n + "'s"


def on_desktop_changed_signal(sender, **kwargs):
    """ Called when a desktop has changed. """
    username = kwargs['username']
    desktop_slug = kwargs['desktop_slug']

    # Clear cached desktop html
    clear_desktop_cached_views(username, desktop_slug)

    Desktop.update_revision_id(username, desktop_slug)

desktop_changed.connect(on_desktop_changed_signal)


def on_user_desktops_change(sender, **kwargs):
    username = kwargs['username']
    update_revision_id = Desktop.update_revision_id

    for desktop_slug in Desktop.objects.filter(owner__username=username)\
                        .values_list('slug', flat=True):

        clear_desktop_cached_views(username, desktop_slug)
        update_revision_id(username, desktop_slug)

user_desktops_changed.connect(on_user_desktops_change)


def on_theme_changed_signal(sender, **kwargs):

    theme = kwargs.get('instance')
    update_revision_id = Desktop.update_revision_id

    for username, desktop_slug in Desktop.objects.filter(theme=theme)\
                                .values_list('owner__username', 'slug'):

        clear_desktop_cached_views(username, desktop_slug)
        update_revision_id(username, desktop_slug)

post_save.connect(on_theme_changed_signal, sender=Theme)


def on_desktop_deleted(sender, **kwargs):
    """ Deletes cache entries for a given desktop. """
    desktop = kwargs.get('instance')
    username = desktop.owner.username
    desktop_slug = desktop.slug

    clear_desktop_cached_views(username, desktop_slug)
    DesktopAPI.clear_desktop_cache(username, desktop_slug)
    Desktop.delete_revision_id(username, desktop_slug)

post_delete.connect(on_desktop_deleted, sender=Desktop)


def on_desktop_saved(sender, **kwargs):
    if sender is not Desktop:
        return
    if not kwargs.get('created'):
        desktop = kwargs.get('instance')
        username = desktop.owner.username
        slug = desktop.slug
        DesktopAPI.set_desktop_cache(username, slug, desktop.definition_json)
        clear_desktop_cached_views(username, slug)
        Desktop.update_revision_id(username, slug)

post_save.connect(on_desktop_saved, sender=Desktop)



def get_desktop_cache_key(action, username, desktop_slug, rev_id=None):

    if rev_id is None:
        rev_id = Desktop.get_revision_id(username, desktop_slug)
    if rev_id is None:
        return None
    return u'.'.join( (action, rev_id, str(settings.CACHE_BUSTER)) )


def get_desktop(username, desktop_slug):
    desktop = get_object_or_404( Desktop,
                                 owner__username = username,
                                 slug = desktop_slug )
    return desktop


def clear_desktop_cached_views(username, desktop_slug):

    rev_id = Desktop.get_revision_id(username, desktop_slug)

    for action in ('getdesktop', 'view', 'etag_anon', 'etag_own', 'etag_another'):
        cache_key = get_desktop_cache_key(action, username, desktop_slug, rev_id=rev_id)
        if cache_key is not None:
            cache.delete(cache_key)



def get_desktop_view_etag(request, username, desktop_slug):
    """ Create an etag for the a given deskop.
    The etag itself its stored in the cache and is a random identifier.
    The cached etag is changed when the desktop changes, so it is always unique.
    """
    if request.user.is_anonymous():
        action = 'etag_anon'
    elif request.user.username == username:
        action = 'etag_own'
    else:
        action = 'etag_another'
    etag_key = get_desktop_cache_key(action, username, desktop_slug)

    return etag_key

def prefix(prefix, f):
    """ Decorator to add a prefix to a returned string. """
    def prefix_f(*args, **kwargs):
        return '%s.%s' % (prefix, f(*args, **kwargs))
    return prefix_f


@etag(get_desktop_view_etag)
def desktop_view(request, username='', desktop_slug=''):
    """ Generates the desktop for viewing. """

    user = request.user
    anon = request.user.is_anonymous()
    staff = 'staff' in request.GET and user.is_staff

    rev_id = Desktop.get_revision_id(username, desktop_slug)
    desktop_cache_key = get_desktop_cache_key('getdesktop', username, desktop_slug, rev_id=rev_id)
    desktop = cache.get(desktop_cache_key, None)

    if desktop is None:
        try:
            desktop = Desktop.objects.get(owner__username=username,
                                             slug=desktop_slug)
        except Desktop.DoesNotExist:
            raise Http404

        cache.set(desktop_cache_key, desktop)

    desktop_owner_user = desktop.owner

    if not request.user.is_staff:
        if desktop.private:
            if anon or request.user != desktop.owner:
                raise Http404

    if request.user.is_anonymous():
        action = 'view_anon'
    elif request.user.username == username:
        action = 'view_own'
    else:
        action = 'view_another'

    if staff:
        action += "_staff"

    view_cache_key = get_desktop_cache_key(action, username, desktop_slug, rev_id=rev_id)

    cached_html = cache.get(view_cache_key, None)
    if cached_html is not None:
        return HttpResponse(cached_html)

    td = {}
    td['desktop'] = desktop
    td['username'] = username
    td['desktop_slug'] = desktop_slug

    td['desktop_name'] = desktop.name if desktop_slug != u'default' else possessive(username) + u' desktop'
    td['theme'] = desktop.theme

    td['definition_json'] = desktop.definition_json

    exclude_private = False
    if not request.user.is_staff:
        if user.is_anonymous() or user.username != username:
            exclude_private = True
    desktops = Desktop.get_desktop_links(desktop_owner_user, exclude_private=exclude_private)

    desktop_url = Desktop.get_desktop_url(username, desktop_slug)

    allow_edit = staff or (user.is_authenticated() and user.username == username)
    own_desktop = user.username == username

    td.update( user=                request.user,
               desktop_owner_user = desktop.owner,
               desktops =           desktops,
               desktop_url =        desktop_url,
               desktop_settings=    dict(private=desktop.private),
               allow_edit =         allow_edit,
               own_desktop =        own_desktop,
               test_account =       username=='test')

    html = render_to_string("desktop/desktop_view.html", td, request)
    cache.set(view_cache_key, html)

    return HttpResponse(html)

class ListIcon(object):
    def __init__(self, icon_def):
        self.icon_def = icon_def
        self.children = []

    def add_child(self, child):
        child.odd = len(self.children)%2
        self.children.append(child)

    def __getitem__(self, name):
        return self.icon_def[name]

    def get(self, name, default=None):
        return self.icon_def.get(name, default)

    def get_image(self, size):
        if self.get('use_favicon') and self.get('has_favicon'):
            img_url = self.icon_def.get('favicon_img_url_template')
        else:
            img_url = self.icon_def.get('img_url_template')
        return img_url.replace('[SIZE]', str(size))



@etag(get_desktop_view_etag)
def desktop_view_list(request, username='', desktop_slug=''):

    user = request.user
    anon = request.user.is_anonymous()
    staff = 'staff' in request.GET and user.is_staff

    rev_id = Desktop.get_revision_id(username, desktop_slug)
    desktop_cache_key = get_desktop_cache_key('getdesktop', username, desktop_slug, rev_id=rev_id)
    desktop = cache.get(desktop_cache_key, None)

    if desktop is None:
        try:
            desktop = Desktop.objects.get(owner__username=username,
                                          slug=desktop_slug)
        except Desktop.DoesNotExist:
            raise Http404

        cache.set(desktop_cache_key, desktop)

    desktop_owner_user = desktop.owner

    if not request.user.is_staff:
        if desktop.private:
            if anon or request.user != desktop.owner:
                raise Http404

    if request.user.is_anonymous():
        action = 'viewlist_anon'
    elif request.user.username == username:
        action = 'viewlist_own'
    else:
        action = 'viewlist_another'

    if staff:
        action += "_staff"

    view_cache_key = get_desktop_cache_key(action, username, desktop_slug, rev_id=rev_id)

    #cached_html = cache.get(view_cache_key, None)
    #if cached_html is not None:
    #    return HttpResponse(cached_html)


    td = {}
    td['settings'] = settings
    td['desktop'] = desktop
    td['desktop_name'] = desktop.name
    td['theme'] = desktop.theme
    td['tagline'] = possessive(desktop.owner.get_full_name() or desktop.owner.username) + " desktop"

    desktop_def = json.loads(desktop.definition_json)

    icons = [ListIcon(icon_def) for icon_def in desktop_def['icons'] if icon_def['type']=='icon']

    stacks = dict((icon_def['icon_id'], ListIcon(icon_def)) for icon_def in desktop_def['icons'] if icon_def['type']=='stack')

    top_icons = []
    for icon in icons:
        stack_name = icon.icon_def.get('stack')
        if stack_name is not None and stack_name in stacks:
            stacks[stack_name].add_child(icon)
        else:
            top_icons.append(icon)

    list_icons = top_icons
    list_icons += stacks.values()
    list_icons.sort(key = lambda i:(bool(i.children), i['name']))
    for icon in list_icons:
        if icon.children:
            icon.children.sort(key=lambda i:i['name'])

    td['list_icons'] = list_icons



    exclude_private = False
    if not request.user.is_staff:
        if user.is_anonymous() or user.username != username:
            exclude_private = True
    desktops = Desktop.get_desktop_links(desktop_owner_user, exclude_private=exclude_private)

    desktop_url = Desktop.get_desktop_url(username, desktop_slug)

    allow_edit = staff or (user.is_authenticated() and user.username == username)
    own_desktop = user.username == username

    #pprint(icons)
    #print icons

    td.update( user=                request.user,
               desktop_owner_user=  desktop.owner,
               desktops =           desktops,
               desktop_url =        desktop_url,
               desktop_settings=    dict(private=desktop.private),
               allow_edit =         allow_edit,
               own_desktop =        own_desktop,
               test_account =       username=='test')

    html = render_to_string("desktop/desktop_view_list.html", td, request)
    cache.set(view_cache_key, html)

    return HttpResponse(html)




def login_or_test_required(function=None):
    """
    Decorator for views that checks that the user is logged in, redirecting
    to the log-in page if necessary.
    """
    actual_decorator = user_passes_test(
        lambda u: u.is_authenticated() or u.username=="test",
        redirect_field_name=None
    )
    if function:
        return actual_decorator(function)
    return actual_decorator



@render_to_template("desktop/desktop.html")
def desktop(request, username, desktop_slug):
    """ Generates the desktop, for editing. """

    if not (request.user.is_authenticated or username=="test"):
        return HttpResponseRedirect('/login/?next=%s' % request.path)

    try:
        desktop = Desktop.objects.get(owner__username=username, slug=desktop_slug)
    except Desktop.DoesNotExist:
        raise Http404

    if not request.user.is_staff and username != 'test':
        # If this isn't the users desktop and the desktop is private
        if request.user != desktop.owner:
            raise Http404

    td = {}
    td['desktop_name'] = desktop.name
    td['user'] = request.user
    td['username'] = username
    td['desktop_slug'] = desktop_slug
    td['initial_dialog'] = request.GET.get('dialog', '')

    td['desktop_private'] = '1' if desktop.private else '0'

    stack_icon = Icon.lookup(settings.DEFAULT_STACK_ICON)

    td['stack_icon_key'] = settings.DEFAULT_STACK_ICON;
    td['stack_icon_sizes'] = stack_icon.sizes
    td['stack_icon_url'] = os.path.join(settings.MEDIA_URL, stack_icon.img_url)

    td['view_url'] = desktop.get_absolute_url()

    td['definition_json'] = DesktopAPI.get_desktop_definition(username, desktop_slug)
    td['theme'] = desktop.theme

    return td


@render_to_template("desktop/desktop.html")
def new_desktop(request):

    #if 'new_desktop_urls' not in request.session:
    #    return HttpResponseRedirect('/')

    new_desktop_urls = request.session.pop('new_desktop_urls', None)
    auth.logout(request)

    td = {}
    td['desktop_name'] = "default"
    td['user'] = request.user
    td['username'] = 'new'
    td['desktop_slug'] = 'default'

    td['desktop_private'] = '0'

    stack_icon = Icon.lookup(settings.DEFAULT_STACK_ICON)

    td['stack_icon_key'] = settings.DEFAULT_STACK_ICON;
    td['stack_icon_sizes'] = stack_icon.sizes
    td['stack_icon_url'] = os.path.join(settings.MEDIA_URL, stack_icon.img_url)

    td['view_url'] = '/'

    td['definition_json'] = '';
    td['hide_menu'] = False
    td['no_greet'] = True
    td['desktop_initial_state'] = ''
    td['new_desktop'] = True
    td['initial_dialog'] = 'new-icon'

    if new_desktop_urls is None:
        td['new_urls'] = json.dumps(None)
    else:
        td['new_urls'] = json.dumps(new_desktop_urls)

    td['theme'] = None

    return td



@render_to_template("desktop/desktop_view_options.html")
def desktop_view_options(request, username, desktop_slug):
    """ An html snippet (requested via ajax) that contain desktop options. """

    td = {}
    td['logged_in'] = not request.user.is_anonymous()
    td['username'] = username
    td['desktop_slug'] = desktop_slug
    td['test_account'] = username == 'test'
    return td

@render_to_template("desktop/iconpacks.html")
def iconpacks(request):

    catalogs = IconCatalog.objects.all().order_by('priority', 'name')

    def get_categories(catalog):
        return sorted(set(c[0] for c in catalog.icon_set.all().values_list('category')))

    catalogs_list = [(catalog.name, get_categories(catalog)) for catalog in catalogs]

    td = {}
    td['catalogs'] = catalogs_list

    return td


@render_to_template("front/index.html")
def front(request):
    """ Generates the destop for viewing. """
    
    td = {}
    return td

#@etag(prefix('links', get_desktop_view_etag))
@render_to_template("desktop/desktop_view_links.html")
def desktop_links(request, username, desktop_slug):

    if 'simple' in request.GET:
        return HttpResponse('')
    user = request.user
    staff = 'staff' in request.GET and user.is_staff
    desktop_owner_user = User.objects.get(username=username)

    exclude_private = False
    if not request.user.is_staff:
        if user.is_anonymous() or user.username != username:
            exclude_private = True
    desktops = Desktop.get_desktop_links(desktop_owner_user, exclude_private=exclude_private)

    desktop_url = Desktop.get_desktop_url(username, desktop_slug)

    desktop_settings = {}
    if request.user.username == username:
        desktop_settings = Desktop.objects.filter(owner__username=username, slug=desktop_slug).values('private')[0]

    allow_edit = staff or (user.is_authenticated() and user.username == username)

    own_desktop = user.username == username

    return dict( user=user,
                 desktop_owner_user=desktop_owner_user,
                 desktops=desktops,
                 username=username,
                 desktop_slug=desktop_slug,
                 desktop_url=desktop_url,
                 desktop_settings=desktop_settings,
                 allow_edit=allow_edit,
                 own_desktop=own_desktop,
                 test_account=username=='test')

def page(request, page_name):

    td = {}
    template_name = 'front/pages/%s.html' % page_name

    try:
        return render_to_response(template_name, td, request=request)
    except TemplateDoesNotExist:
        raise Http404


@render_to_template("desktop/desktop_welcome.html")
def desktop_welcome(request):
    return dict(user=request.user)
