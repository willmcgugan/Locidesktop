from django.http import HttpResponse
from djangojinja2 import render_to_response


def render_to_template(template_name):

    def deco(f):

        def new_f(request, *args, **kwargs):

            ret = f(request, *args, **kwargs)
            if isinstance(ret, HttpResponse):
                return ret
            ret['request'] = request
            ret['view_params'] = kwargs
            return render_to_response(template_name, ret, request=request)

        return new_f

    return deco