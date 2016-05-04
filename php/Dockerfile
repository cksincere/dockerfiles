FROM php:5.6-apache
MAINTAINER developers@khipu.com

RUN groupmod -g 2000 www-data && \
    usermod -u 2000 -g 2000 www-data

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) mysql

RUN find /var -uid 33 | xargs chown -R www-data:www-data
RUN find /run -uid 33 | xargs chown -R www-data:www-data
