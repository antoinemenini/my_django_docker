FROM kolibree/python_base

MAINTAINER Antoine Menini "antoine.menini@kolibree.com"

# Add application
ADD ./my_djangodocker/ /opt/django/app/

RUN pip install uwsgi
ADD ./ops/uwsgi.ini /opt/uwsgi/uwsgi.ini

RUN pip install -r /opt/django/app/requirements.txt

RUN rm /etc/nginx/sites-enabled/default
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD ./ops/django_nginx.conf /etc/nginx/sites-available/django_nginx.conf
ADD ./ops/uwsgi_params /opt/uwsgi/uwsgi_params
RUN ln -s /etc/nginx/sites-available/django_nginx.conf /etc/nginx/sites-enabled/
# we stop nginx because it will be run by supervisord
RUN service nginx stop

ADD ./ops/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80
CMD ["/usr/bin/supervisord",  "-n"]