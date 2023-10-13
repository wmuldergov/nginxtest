FROM nginx:stable

COPY ./src/caching/nginx.conf /etc/nginx/nginx.conf
COPY ./src/caching/index.html /usr/share/nginx/html
COPY ./src/caching/nocachetest.html /usr/share/nginx/html

RUN chmod -R 777 /var/cache/nginx
RUN chmod -R 777 /var/log/nginx
#temp run command as I test updating a file
RUN chmod -R 777 /usr/share/nginx/html
CMD /usr/sbin/nginx -g 'daemon off;'

COPY ./compose/caching/entrypoint /
RUN sed -i 's/\r$//g' /entrypoint && chmod +x /entrypoint

ENTRYPOINT ["/entrypoint"]
