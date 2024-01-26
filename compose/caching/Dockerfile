FROM nginx:stable-alpine


#COPY ./src/caching/nginx.conf /etc/nginx/nginx.conf
#Copy the template file to the nginx folder as well for testing
COPY ./src/caching/nginx.conf /etc/nginx/
RUN mkdir -p /etc/apache2
#RUN touch /etc/apache2/.htpasswd

COPY ./src/caching/index.html /usr/share/nginx/html
COPY ./src/caching/nocachetest.html /usr/share/nginx/html
COPY ./src/caching/.htpasswd /etc/apache2

RUN chmod -R 777 /var/cache/nginx
RUN chmod -R 777 /var/log/nginx
RUN chmod -R 775 /etc/nginx
#temp run commands as I test updating a file. Won't be needed once I get rid of index file.
RUN chmod -R 777 /usr/share/nginx/html
RUN chmod -R 777 /etc/apache2/.htpasswd


CMD /usr/sbin/nginx -g 'daemon off;'

COPY ./compose/caching/entrypoint /
RUN sed -i 's/\r$//g' /entrypoint && chmod +x /entrypoint

ENTRYPOINT ["/entrypoint"]
