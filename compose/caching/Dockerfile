FROM nginx:stable

COPY ./src/caching/nginx.conf /etc/nginx/nginx.conf
COPY ./src/caching/index.html /usr/share/nginx/html
COPY ./src/caching/nocachetest.html /usr/share/nginx/html

RUN chmod -R 777 /var/cache/nginx
RUN chmod -R 777 /var/log/nginx
CMD /usr/sbin/nginx -g 'daemon off;'
