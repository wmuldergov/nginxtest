FROM nginx:stable

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./index.html /usr/share/nginx/html
COPY ./nocachetest.html /usr/share/nginx/html

RUN chmod -R 777 /var/cache/nginx
RUN chmod -R 777 /var/log/nginx
CMD /usr/sbin/nginx -g 'daemon off;'
