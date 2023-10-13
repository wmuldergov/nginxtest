FROM nginx:stable
RUN apt-get update && \
    apt-get install -y \
      nano \
      wget && \
      rm -rf /var/cache/apt

RUN wget https://raw.githubusercontent.com/wmuldergov/nginxtest/main/nginx.conf
RUN wget https://raw.githubusercontent.com/wmuldergov/nginxtest/main/index.html
RUN wget https://raw.githubusercontent.com/wmuldergov/nginxtest/main/nocachetest.html
RUN mv index.html /usr/share/nginx/html
RUN mv nocachetest.html /usr/share/nginx/html
RUN mv nginx.conf /etc/nginx/nginx.conf
RUN chmod -R 777 /var/cache/nginx
RUN chmod -R 777 /var/log/nginx
CMD /usr/sbin/nginx -g 'daemon off;'
