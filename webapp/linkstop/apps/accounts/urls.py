from django.conf.urls.defaults import *

urlpatterns = patterns( 'linkstop.apps.accounts.views',
                       url('^logout/$', 'logout', name="logout"),
                       url('^login/$', 'login', name="login" ),
                       url('^create/$', 'create', name="create_account" ),
                       url('^create-inline/$', 'create_inline', name="inline_create_account" ),
                       )
