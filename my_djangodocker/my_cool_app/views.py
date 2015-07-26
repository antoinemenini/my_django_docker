from django.shortcuts import render
from my_djangodocker import settings


def index(request):
    env = getattr(settings, 'DJANGO_ENV', "default")
    return render(request, 'my_cool_app/index.html', {"env": env})
