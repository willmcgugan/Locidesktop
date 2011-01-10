
from django.conf.urls.defaults import *

from views import *

urlpatterns = patterns( 'linkstop.apps.desktop.views',
    url(r'^new/$', 'new_desktop', name="new_desktop"),
    url(r'^(?P<username>[\w-]{2,})/(?P<desktop_slug>[\w-]+)/$', 'desktop_view', name="desktop_view"),
    url(r'^(?P<username>[\w-]{2,})/(?P<desktop_slug>[\w-]+)/edit/$', 'desktop', name="desktop_edit"),
    url(r'^(?P<username>[\w-]{2,})/(?P<desktop_slug>[\w-]+)/list/$', 'desktop_view_list', name="desktop_view_list"),

    url(r'^(?P<username>[\w-]{2,})/$', 'desktop_view', {'desktop_slug':'default'}, name="desktop_view_default"),

    url(r'^ajax/(?P<username>[\w-]{2,})/(?P<desktop_slug>[\w-]+)/view_options/$', 'desktop_view_options', name="desktop_view_options"),
    url(r'^ajax/(?P<username>[\w-]{2,})/(?P<desktop_slug>[\w-]+)/links/$', 'desktop_links' ),

                       )