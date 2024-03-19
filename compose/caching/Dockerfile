FROM nginx:stable-alpine

RUN apk add logrotate
#RUN apk add --update busybox-initscripts

RUN adduser -D defineduser

#COPY ./src/caching/nginx.conf /etc/nginx/nginx.conf
#Copy the template file to the nginx folder as well for testing
COPY ./src/caching/nginx.conf /etc/nginx/
#THREE LINES BELOW ARE TEMP FOR BETA
RUN mkdir -p /etc/apache2 
RUN touch /etc/apache2/.htpasswd 
RUN chmod -R 777 /etc/apache2/.htpasswd
RUN chmod +w /etc/apache2/

COPY ./src/caching/index.html /usr/share/nginx/html
COPY ./src/caching/nocachetest.html /usr/share/nginx/html
#COPY ./src/caching/.htpasswd /etc/apache2

RUN chmod -R 777 /var/cache/nginx
RUN chmod -R 777 /var/log/nginx
RUN chmod -R 775 /etc/nginx
#temp run commands as I test updating a file. Won't be needed once I get rid of index file.
RUN chmod -R 777 /usr/share/nginx/html



COPY ./compose/caching/entrypoint /
RUN sed -i 's/\r$//g' /entrypoint && chmod +x /entrypoint

#setup logrotate
COPY ./src/caching/nginx-logrotate.conf /etc/logrotate.d/nginx
COPY ./src/caching/logrotate-job.conf /etc/periodic/15min/logrotate
COPY ./src/caching/crontab.conf /var/spool/cron/crontabs/defineduser
COPY ./src/caching/run_periodic_task.sh /usr/local/bin/run_periodic_task.sh
RUN chmod +x /etc/periodic/15min/logrotate
RUN chmod -R 777 /var/spool/cron/crontabs/root
RUN rm /var/spool/cron/crontabs/root
RUN chmod -R 777 /var/spool/cron/crontabs/defineduser
RUN chmod +x /usr/local/bin/run_periodic_task.sh



USER defineduser

#CMD /usr/sbin/nginx -g 'daemon off;'
CMD ["sh", "-c", "/usr/local/bin/run_periodic_task.sh & nginx -g 'daemon off;'"]

ENTRYPOINT ["/entrypoint"]
