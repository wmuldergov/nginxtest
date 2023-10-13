FROM nginx:stable


COPY ./src/caching/nginx.conf /etc/nginx/nginx.conf
#TEMP to see if I can update the file successfully
RUN mkdir /tmp/staging
COPY ./src/caching/nginxtest.conf /tmp/staging

COPY ./src/caching/index.html /usr/share/nginx/html
COPY ./src/caching/nocachetest.html /usr/share/nginx/html

RUN chmod -R 777 /var/cache/nginx
RUN chmod -R 777 /var/log/nginx

#temp run commands as I test updating a file. Won't be needed once I get rid of index file.
RUN chmod -R 777 /usr/share/nginx/html
RUN chmod -R 777 /tmp/staging


CMD /usr/sbin/nginx -g 'daemon off;'

COPY ./compose/caching/entrypoint /
RUN sed -i 's/\r$//g' /entrypoint && chmod +x /entrypoint

ENTRYPOINT ["/entrypoint"]
