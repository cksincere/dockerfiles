FROM ubuntu:trusty
MAINTAINER developers@khipu.com

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
  apt-get -y install supervisor apache2 libapache2-mod-php5 php5-mysql pwgen php-apc php5-mcrypt php5-gd && \
  echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Add image configuration and scripts
ADD start-apache2.sh /start-apache2.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf

# config to enable .htaccess
ADD apache_default /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

#Environment variables to configure php
ENV PHP_UPLOAD_MAX_FILESIZE 10M
ENV PHP_POST_MAX_SIZE 10M

RUN groupmod -g 2000 www-data && \
    usermod -u 2000 -g 2000 www-data

RUN find /var -uid 33 | xargs chown -R www-data:www-data
RUN find /run -uid 33 | xargs chown -R www-data:www-data

CMD ["/run.sh"]
