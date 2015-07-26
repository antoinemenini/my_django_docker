#!/bin/bash -e
j2 ./local_settings.py.j2 $1 > ./my_djangodocker/my_djangodocker/local_settings.py