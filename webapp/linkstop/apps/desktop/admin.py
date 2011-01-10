from django.contrib import admin
from models import *


class IconCatalogAdmin(admin.ModelAdmin):
    list_display = ('name',)

admin.site.register(IconCatalog, IconCatalogAdmin)


def rerender(modeladmin, request, queryset):
    for fi in queryset:
        fi.mark_for_render()
rerender.short_description = "Mark favicons for a re-render"

class FavIconAdmin(admin.ModelAdmin):
    list_display = ('normalized_url', 'sizes', 'date_modified', 'get_icons_html')
    list_filter = ('date_modified',)
    search_fields = ('url', 'normalized_url')
    actions = (rerender,)

admin.site.register(FavIcon, FavIconAdmin)


class IconAdmin(admin.ModelAdmin):
    list_display = ('name', 'catalog', 'category', 'get_icons_html', 'sizes')
    list_filter = ('catalog', 'category',)
    search_fields = ('name',)

admin.site.register(Icon, IconAdmin)


class ResourceAdmin(admin.ModelAdmin):
    list_display = ('name', 'url')

admin.site.register(Resource, ResourceAdmin)


class DesktopAdmin(admin.ModelAdmin):
    list_display = ('name', 'owner', 'private', 'date_created', 'date_modified', 'desktop_link')
    list_filter = ('private', 'date_created', 'date_modified')
    search_fields = ('name', 'owner__username')

admin.site.register(Desktop, DesktopAdmin)


class AutoUrlAdmin(admin.ModelAdmin):
    list_display = ('url', 'pk')
    search_fields = ('url',)

admin.site.register(AutoUrl, AutoUrlAdmin)

class SubUrlSearchAdmin(admin.ModelAdmin):
    list_display = ('sub', 'pks')

admin.site.register(SubUrlSearch, SubUrlSearchAdmin)

class DesktopRatingAdmin(admin.ModelAdmin):
    list_display = ('user', 'desktop', 'rating')
    search_fields = ('user__username',)

admin.site.register(DesktopRating, DesktopRatingAdmin)

class ThemeAdmin(admin.ModelAdmin):
    list_display = ('name', 'owner', 'date_modified', 'approved')
    
admin.site.register(Theme, ThemeAdmin)

class ClipAdmin(admin.ModelAdmin):
    list_display =  ('__unicode__', 'owner', 'date_created', 'clip_type')
    search_fields = ('owner_username',)
    
admin.site.register(Clip, ClipAdmin)
