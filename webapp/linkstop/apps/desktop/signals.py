import django.dispatch

desktop_changed = django.dispatch.Signal(providing_args=["username", "desktop_slug"])
user_desktops_changed = django.dispatch.Signal(providing_args=["username"])
