# -*- coding: utf-8 -*-
__author__ = 'antoinemenini'
__created__ = '25/07/15'

from django.conf.urls import patterns, url
from my_cool_app import views

urlpatterns = patterns(
    '',
    url(r'^$', views.index, name='index'),
)