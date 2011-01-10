from django.conf.urls.defaults import *

from linkstop.apps.desktop.api.views import the_api

urlpatterns = the_api._patterns
