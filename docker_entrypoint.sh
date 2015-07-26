#!/bin/bash -e
j2 /opt/django/local_settings.py.j2 > /opt/django/app/my_djangodocker/local_settings.py
exec "$@"