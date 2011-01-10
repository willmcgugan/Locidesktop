from linkstop.shortcuts import *
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import *
from django.http import HttpResponseRedirect
from django.core.urlresolvers import reverse
from linkstop.apps.accounts.models import *
from linkstop.urls import is_reserved_path
from linkstop.tools import send_template_email, slugify

from django.core.validators import email_re
from django.conf import settings

from collections import defaultdict


@render_to_template('front/login.html')
def login(request):

    td = {}
    td['sections'] = {}
    td['next'] = request.GET.get('next', '')

    if request.method == "POST":
        username = request.POST.get('username', '')
        password = request.POST.get('password', '')
        next = request.REQUEST.get('next')

        user = auth.authenticate(username=username, password=password)

        if user is not None:
            auth.login(request, user)
            if next:
                return HttpResponseRedirect(next)
            else:
                return HttpResponseRedirect('/%s/' % username)

        td['failed'] = True

    return td


def logout(request):

    auth.logout(request)
    next = request.GET.get('next', '/')

    return HttpResponseRedirect(next)


def _create(request, view_name='create_account'):

    td = {}
    td['form_url'] = reverse(view_name)

    form = request.POST.get
    errors = defaultdict(list)

    invite = slugify(request.GET.get('invite', '').strip())
    if invite:
        td['invite'] = invite

    def add_error(field, error):
        errors[field].append(error)

    if request.method == "POST":

        invite = form('invite', '').strip()
        first_name = form('first_name', '').strip()
        last_name = form('last_name', '').strip()
        email = form('email', '').strip()
        username = slugify(form('username', '').strip().lower())
        password = form('password', '')
        password_check = form('password_check', '')

        if settings.REQUIRE_INVITE:
            if not invite:
                add_error('invite', 'Invite code is required')
            else:
                try:
                    Invite.check(invite)
                except InviteError, e:
                    add_error('invite', str(e))

        if not first_name:
            add_error('first_name', "First name is required")

        if not email:
            add_error('email', 'Email is required')
        elif not email_re.match(email):
            add_error('email', "Doesn't look like an email")

        if email:
            try:
                user = User.objects.get(email=email)
            except User.DoesNotExist:
                pass
            else:
                add_error('email', 'An account with this email address already exists')

        if username:
            try:
                user = User.objects.get(username=username)
            except User.DoesNotExist:
                pass
            else:
                add_error('username', 'An account with this username address already exists')

        if not username:
            add_error('username', 'Username is required')
        elif len(username) <= 3:
            add_error('username', 'Username is too short (must be greater than 3 characters)')
        elif is_reserved_path(username):
            add_error('username', 'Sorry, this username is reserved')

        if not password:
            add_error('password', 'Password is required')

        elif len(password) <= 3:
            add_error('password', 'Password is too short (must be greater than 3 characters)')

        if password != password_check:
            add_error('password_check', 'Passwords do not match')
            password = password_check = ''


        td.update( invite=invite,
                   first_name=first_name,
                   last_name=last_name,
                   email=email,
                   username=username,
                   password=password,
                   password_check=password_check )

        if not errors:
            try:
                if settings.REQUIRE_INVITE:
                    Invite.use(invite)
                new_profile = Profile.create( username,
                                              password,
                                              email,
                                              first_name=first_name,
                                              last_name=last_name )

            except InviteError, e:
                add_error('invite', str(e))

            except ValueError, e:
                field, msg = str(e).split(':')
                add_error(field, msg)

            else:
                home_desktop = Desktop.objects.get(name='default', owner=new_profile.user)
                
                new_desktop_definition = request.session.get('new_desktop_definition')
                if new_desktop_definition:
                    home_desktop.definition_json = new_desktop_definition
                home_desktop.save()
                
                home_desktop_url = home_desktop.get_absolute_url()
                home_desktop_edit_url = home_desktop.get_edit_url()

                email_td = dict( name=new_profile.user.get_full_name() or new_profile.user.username,
                                 home_desktop_url=settings.SITE_URL+home_desktop_url)
                send_template_email('Welcome', 'welcome', email_td, email)

                user = auth.authenticate(username=username, password=password)
                auth.login(request, user)
                return HttpResponseRedirect(home_desktop_edit_url)

    td['errors'] = dict(errors.iteritems())

    return td

@render_to_template('front/create_account.html')
def create(request):
    return _create(request)

@render_to_template('front/inline_create_account.html')
def create_inline(request):

    result = _create(request, 'inline_create_account')
    if isinstance(result, dict):
        return result

    if isinstance(result, HttpResponseRedirect):
        return dict(success=True, username=request.user.username)

    assert False, "Should never get here"