from django.db import models
from django.db.transaction import commit_on_success
from django.contrib.auth.models import User

from linkstop.tools import JSONPropertyDescriptor

from linkstop.apps.desktop.models import Desktop

class Profile(models.Model):

    user = models.OneToOneField(User, null=False)

    settings_json =  models.TextField( "profile global settings",
                                       blank=True,
                                       null=True )

    settings = JSONPropertyDescriptor('settings_json')

    @classmethod
    @commit_on_success
    def create(self, username, password, email, first_name='', last_name=''):

        user, created_user =\
            User.objects.get_or_create( username=username,
                                        email=email,
                                        defaults=dict(first_name=first_name, last_name=last_name))

        if not created_user:
            raise ValueError("username:Sorry, this username has been taken")

        user.set_password(password)
        user.save()
        profile, created_profile = Profile.objects.get_or_create(user=user, defaults=dict(settings_json=''))

        Desktop.create_default_desktop(user)

        return profile


class InviteError(ValueError):
    pass

class Invite(models.Model):

    code = models.CharField(max_length=20)
    max_use = models.IntegerField(default=1)
    used_count = models.IntegerField(default=0)


    def uses_remaining(self):
        return max(0, self.max_use - self.used_count)

    @classmethod
    @commit_on_success
    def use(self, code):
        """ Use the code, if exists and valid. """
        try:
            invite = Invite.objects.get(code=code)
        except Invite.DoesNotExist:
            raise InviteError("Invite code is incorrect")

        if invite.used_count >= invite.max_use:
            raise InviteError("Sorry, this invite code has reached its maximum number of uses")

        invite.used_count += 1
        invite.save()



    @classmethod
    def check(cls, code):
        """ Checks the code can potentially be used. """
        try:
            invite = Invite.objects.get(code=code)
        except Invite.DoesNotExist:
            raise InviteError("Invite code is incorrect")

        if invite.used_count >= invite.max_use:
            raise InviteError("Sorry, this invite code has reached its maximum number of uses")

        return True
