FROM kolibree/python_base

MAINTAINER Antoine Menini "antoine.menini@kolibree.com"

# Add application
ADD ./my_djangodocker/ /opt/django/app/

ADD ./ops/uwsgi.ini /opt/uwsgi/uwsgi.ini

RUN pip install -r /opt/django/app/requirements.txt

RUN pip install uwsgi
RUN pip install j2cli

ADD ./local_settings.py.j2 /opt/django/local_settings.py.j2
ADD ./docker_entrypoint.sh /opt/django/docker_entrypoint.sh

RUN rm /etc/nginx/sites-enabled/default
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD ./ops/django_nginx.conf /etc/nginx/sites-available/django_nginx.conf
ADD ./ops/uwsgi_params /opt/uwsgi/uwsgi_params
RUN ln -s /etc/nginx/sites-available/django_nginx.conf /etc/nginx/sites-enabled/
# we stop nginx because it will be run by supervisord
RUN service nginx stop

ADD ./ops/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80

ENTRYPOINT ["/opt/django/docker_entrypoint.sh"]
CMD ["/usr/bin/supervisord",  "-n"]
# ENTRYPOINT ["/bin/bash"]