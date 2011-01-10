# Django settings for linkstop project.

from os.path import join, dirname, abspath
SETTINGS_PATH = dirname(__file__)

def project_path(pth):
    return abspath(join(SETTINGS_PATH, pth)).replace('\\', '/')

DEBUG = True
TEMPLATE_DEBUG = True

ADMINS = (
    
)

MANAGERS = ADMINS

DATABASE_ENGINE = 'sqlite3'           # 'postgresql_psycopg2', 'postgresql', 'mysql', 'sqlite3' or 'oracle'.
DATABASE_NAME = project_path('linkstop.db')             # Or path to database file if using sqlite3.
DATABASE_USER = ''             # Not used with sqlite3.
DATABASE_PASSWORD = ''         # Not used with sqlite3.
DATABASE_HOST = ''             # Set to empty string for localhost. Not used with sqlite3.
DATABASE_PORT = ''             # Set to empty string for default. Not used with sqlite3.

# Local time zone for this installation. Choices can be found here:
# http://en.wikipedia.org/wiki/List_of_tz_zones_by_name
# although not all choices may be available on all operating systems.
# If running in a Windows environment this must be set to the same as your
# system time zone.
TIME_ZONE = 'London/Europe'

# Language code for this installation. All choices can be found here:
# http://www.i18nguy.com/unicode/language-identifiers.html
LANGUAGE_CODE = 'en-us'

SITE_ID = 1

# If you set this to False, Django will make some optimizations so as not
# to load the internationalization machinery.
USE_I18N = False

# Absolute path to the directory that holds media.
# Example: "/home/media/media.lawrence.com/"
MEDIA_ROOT = project_path('media')

# URL that handles the media served from MEDIA_ROOT. Make sure to use a
# trailing slash if there is a path component (optional in other cases).
# Examples: "http://media.lawrence.com", "http://example.com/media/"
MEDIA_URL = 'http://localhost:8000/media/'

# URL prefix for admin media -- CSS, JavaScript and images. Make sure to use a
# trailing slash.
# Examples: "http://foo.com/media/", "/media/".
ADMIN_MEDIA_PREFIX = '/admin-media/'

# Make this unique, and don't share it with anybody.
SECRET_KEY = 'kedkeh38fn46dh23nckl342$48232_248fkjdf n390!$gkdd'

# List of callables that know how to import templates from various sources.
TEMPLATE_LOADERS = (
    'django.template.loaders.filesystem.load_template_source',
    'django.template.loaders.app_directories.load_template_source',
#     'django.template.loaders.eggs.load_template_source',
)

MIDDLEWARE_CLASSES = (
    'django.middleware.common.CommonMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
)

ROOT_URLCONF = 'linkstop.urls'


TEMPLATE_DIRS = (
    # Put strings here, like "/home/html/django_templates" or "C:/www/django/templates".
    # Always use forward slashes, even on Windows.
    # Don't forget to use absolute paths, not relative paths.
    #abspath(join(SETTINGS_PATH, 'templates')).replace('\\', '/')
    project_path('templates'),
)

INSTALLED_APPS = (
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.sites',
    'django.contrib.admin',
    'django.contrib.admindocs',

    'linkstop.apps.accounts',
    'linkstop.apps.desktop',

)

#TEMPLATE_CONTEXT_PROCESSORS = (
#
#    "django.core.context_processors.request",
#)

AUTH_PROFILE_MODULE = 'accounts.profile'

STATIC_DOC_ROOT = project_path('media')

DESKTOP_ICON_SIZES = [16, 32, 48, 64, 96, 128]
DESKTOP_FORCE_ICON_SIZES = [16, 32, 48, 64, 96, 128]
DEFAULT_ICON = 'crystal_project.devices.Globe2'
DEFAULT_STACK_ICON = 'crystal_project.apps.kthememgr'
DEFAULT_ICON_SIZE = 48
FAVICON_POV_SCENE = project_path('favicon/favicon.pov')
FAVICON_ROOT = join(MEDIA_ROOT, 'favicons')
FAVICON_URL = join(MEDIA_URL, 'favicons')

ADMIN_USERNAME = 'admin'
FRONT_PAGE_DESKTOP ='frontpage'

SEND_EMAIL = False
EMAIL_HOST = 'localhost'
EMAIL_PORT = 25
REQUIRE_INVITE = False

SITE_NAME = 'http://localhost:8000/'
SITE_URL = 'http://localhost:8000/'

CACHE_BUSTER = 1
DESKTOP_CACHE_BUSTER = 1

DEFAULT_FROM_EMAIL = "will@willmcgugan.com"
SYSTEM_EMAIL_PREFIX = "[Loci Desktop]"

#CACHE_BACKEND = "memcached://127.0.0.1:11211/"
CACHE_BACKEND = "locmem://"

DESKTOP_API_DEBUG = True

try:
    from settings_local import *
except ImportError:
    pass