from __future__ import with_statement

from django.core.management.base import BaseCommand, CommandError
from linkstop.apps.desktop.models import *
from linkstop.apps.accounts.models import *
from django.contrib.auth.models import *
from django.conf import settings
from django.db import IntegrityError
from getpass import getpass

class Command(BaseCommand):

    def handle(self, *params, **options):

        admin_username = settings.ADMIN_USERNAME
        
        
        has_admin_user = bool(User.objects.filter(username=admin_username).count())        


        if not has_admin_user:
            while True:
                email = raw_input('Enter admin user email: ').strip()
                try:
                    User.objects.get(email=email)
                except User.DoesNotExist:
                    break
                print "Email must be unique"            
            password = getpass('Admin user password: ').strip()
            if not password:
                print "Exit"
                return
    
            admin_profile = Profile.create(admin_username, password, email)
            admin_user = admin_profile.user
            admin_user.is_staff = True
            admin_user.is_superuser = True
            admin_user.save()
    
            print "Created admin user"
            
        else:
            admin_profile = User.objects.get(username=admin_username).get_profile()

        try:
            default_admin_desktop = Desktop.objects.create( owner=admin_profile.user,
                                                            name="default",
                                                            slug="default",
                                                            private=True,
                                                            searchable=False )
            print "Created admin default desktop"
            
        except IntegrityError:
            pass
        

        try:
            front_page_admin_desktop = Desktop.objects.create(  owner=admin_profile.user,
                                                                name=settings.FRONT_PAGE_DESKTOP,
                                                                slug=settings.FRONT_PAGE_DESKTOP,
                                                                private=True,
                                                                searchable=False )
            print "Created front page desktop"
            
        except IntegrityError:
            pass
        
