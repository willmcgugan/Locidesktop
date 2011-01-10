# -*- coding: utf-8 -*-
"""
    djangojinja2
    ~~~~~~~~~~~~

    Adds support for Jinja2 to Django.

    Configuration variables:

    ======================= =============================================
    Key                     Description
    ======================= =============================================
    `JINJA2_TEMPLATE_DIRS`  List of template folders
    `JINJA2_EXTENSIONS`     List of Jinja2 extensions to use
    `JINJA2_CACHE_SIZE`     The size of the Jinja2 template cache.
    ======================= =============================================

    :copyright: Copyright 2008 by Armin Ronacher.
    :license: BSD.
"""
from itertools import chain
from django.conf import settings
from django.core.exceptions import ImproperlyConfigured
from django.template.context import get_standard_processors
from django.template import TemplateDoesNotExist
from jinja2 import Environment, FileSystemLoader, TemplateNotFound
from jinja2.defaults import DEFAULT_NAMESPACE
from django.http import HttpResponse


# the environment is unconfigured until the first template is loaded.
_jinja_env = None


def get_env():
    """Get the Jinja2 env and initialize it if necessary."""
    global _jinja_env
    if _jinja_env is None:
        _jinja_env = create_env()
    return _jinja_env


def create_env():
    """Create a new Jinja2 environment."""
    searchpath = list(settings.TEMPLATE_DIRS)
    return Environment(loader=FileSystemLoader(searchpath),
                       auto_reload=settings.TEMPLATE_DEBUG,
                       cache_size=getattr(settings, 'JINJA2_CACHE_SIZE', 50),
                       )


def get_template(template_name, globals=None):
    """Load a template."""
    try:
        return get_env().get_template(template_name, globals=globals)
    except TemplateNotFound, e:
        raise TemplateDoesNotExist(str(e))


def select_template(templates, globals=None):
    """Try to load one of the given templates."""
    env = get_env()
    for template in templates:
        try:
            return env.get_template(template, globals=globals)
        except TemplateNotFound:
            continue
    raise TemplateDoesNotExist(', '.join(templates))


def render_to_string(template_name, context=None, request=None,
                     processors=None):
    """Render a template into a string."""
    context = dict(context or {})
    context['settings'] = settings
    if request is not None:
        context['request'] = request        
        for processor in chain(get_standard_processors(), processors or ()):
            context.update(processor(request))
    return get_template(template_name).render(context)


def render_to_response(template_name, context=None, request=None,
                       processors=None, mimetype=None):
    """Render a template into a response object."""
    context['settings'] = settings
    return HttpResponse(render_to_string(template_name, context, request,
                                         processors), mimetype=None)
