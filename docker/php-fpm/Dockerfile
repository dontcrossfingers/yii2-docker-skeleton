FROM php:7.1-fpm

ENV TIMEZONE Europe/Moscow

RUN echo "${TIMEZONE}" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    echo "date.timezone = ${TIMEZONE}" > /usr/local/etc/php/php.ini && \
    echo "short_open_tag = off" >> /usr/local/etc/php/php.ini && \
    echo "log_errors = yes" >> /usr/local/etc/php/php.ini && \
    echo "display_errors = yes" >> /usr/local/etc/php/php.ini && \
    echo "catch_workers_output = yes" >> /usr/local/etc/php/php.ini && \
    apt-get -qq update && \
    apt-get install -y \
    libpq-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpcre3-dev \
    libpng12-dev \
    libicu-dev \
    libmemcached-dev \
    vim \
    && \
    docker-php-ext-install opcache pdo pdo_mysql pdo_pgsql gd zip intl && \
    docker-php-ext-install -j$(nproc) iconv mcrypt mbstring bcmath && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/  && \
    docker-php-ext-install -j$(nproc) gd && \
    pecl install memcached && docker-php-ext-enable memcached && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ARG XDEBUG_ENABLE

RUN if [ "$XDEBUG_ENABLE" = "1" ] ; then pecl install xdebug && docker-php-ext-enable xdebug \
 && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/php.ini \
 && echo "xdebug.remote_connect_back=1" >>  /usr/local/etc/php/php.ini \
 && echo "xdebug.remote_autostart=on" >>  /usr/local/etc/php/php.ini \
 && echo "xdebug.remote_handler=dbgp" >> /usr/local/etc/php/php.ini \
 && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/php.ini \
 && echo "xdebug.remote_mode=req" >> /usr/local/etc/php/php.ini \
 && echo "xdebug.remote_port=9009" >> /usr/local/etc/php/php.ini \
 && echo "xdebug.idekey = \"PHPSTORM\"" >> /usr/local/etc/php/php.ini \
 && echo "xdebug.profiler_enable=on" >> /usr/local/etc/php/php.ini \
 && echo "xdebug.profiler_output_dir=\"/app/var/logs/xdebug\"" >> /usr/local/etc/php/php.ini \
 && echo "xdebug.profiler_append=on" >> /usr/local/etc/php/php.ini ; fi