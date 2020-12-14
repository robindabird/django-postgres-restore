from django.conf import settings
from django.conf.urls import include, url
from django.contrib import admin
from store import views as store_views

urlpatterns = [
    url(r'^$', store_views.index),
    url(r'^admin/', admin.site.urls),
    url(r'^store/', include(('store.urls', 'store'), namespace='store')),
]

if settings.DEBUG:
    import debug_toolbar
    urlpatterns = [
        url(r'^__debug__/', include(debug_toolbar.urls)),
    ] + urlpatterns
