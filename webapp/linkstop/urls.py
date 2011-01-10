from django.conf.urls.defaults import *
from django.conf import settings

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',

    #url(r'^$', 'linkstop.apps.desktop.views.front'),
    url(r'^$', 'linkstop.apps.desktop.views.desktop_welcome'),

    (r'^api/', include('linkstop.apps.desktop.api.urls')),

    # Uncomment the admin/doc line below and add 'django.contrib.admindocs'
    # to INSTALLED_APPS to enable admin documentation:
    (r'^djadmin/doc/', include('django.contrib.admindocs.urls')),

    (r'^djadmin/', include(admin.site.urls)),

    #(r'^top/$', 'linkstop.apps.desktop.views.desktop_top_urls'),

    (r'^accounts/', include('linkstop.apps.accounts.urls')),

    #(r'^media/js/(?P<path>.*)$', 'django.views.static.serve',
     #   {'document_root': settings.STATIC_DOC_ROOT+'/minijs/'}),

    (r'^media/(?P<path>.*)$', 'django.views.static.serve',
        {'document_root': settings.STATIC_DOC_ROOT}),


    (r'^iconpacks/$', 'linkstop.apps.desktop.views.iconpacks'),

    url(r'^pages/(?P<page_name>[\w-]+)/$', 'linkstop.apps.desktop.views.page'),

    (r'^', include('linkstop.apps.desktop.urls')),

)

RESERVED_PATHS = frozenset([    'api',
                                'djadmin',
                                'media',
                                'accounts',
                                'settings',
                                'pages',
                                'forum',
                                'blog',
                                'feed',
                                'rss',
                                'login',
                                'logout',
                                'faq',
                                'themes',
                                'icons',
                                'iconpacks',
                                'pages',
                                'new',
                                'edit'
                            ])

def is_reserved_path(path):
    return path.partition('/')[0].lower() in RESERVED_PATHS
