# #############################################################################
# Original PHP-FPM Alpine 
# #############################################################################
FROM php:8.1-fpm-alpine

ENV image_version="1.0"
ENV PHP_VERSION=8.1

LABEL maintainer="me@ShGoudarzi.ir" \
    version=${image_version} \
    description="Original PHP-FPM Alpine + Useful PHP extensions + Apply Basic configuration"


# #############################################################################
#  Useful PHP extensions 
# #############################################################################

ENV EXTENSIONS=" @composer \
    bcmath \
    bz2 \
    calendar \
    dba \
    exif \
    gd \
    gettext \
    gmp \
    imagick \
    imap \
    intl \
    ioncube_loader \
    memcache \
    memcached \
    mysqli \
    odbc \
    opcache \
    pcntl \
    pdo_mysql \
    pdo_odbc \
    pdo_pgsql \
    pgsql \
    soap \
    sockets \
    sourceguardian \
    tidy \
    timezonedb \
    xmlrpc \
    xsl \
    zip"


# Base Installation
RUN apk update && apk upgrade \
    && curl -sSLf \
    -o /usr/local/bin/install-php-extensions \
    https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions \
    && chmod +x /usr/local/bin/install-php-extensions \
    && install-php-extensions ${EXTENSIONS}


# #############################################################################
# Apply Basic configuration
# #############################################################################
ENV PHP_INI=$PHP_INI_DIR/php.ini
RUN rm -f $PHP_INI_DIR/php.ini-development && mv $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini \
    # General
    && sed -i 's/short_open_tag = Off/short_open_tag = On/g' ${PHP_INI} \
    && sed -i 's/disable_functions =/disable_functions = "show_source, system, shell_exec, passthru, exec, popen, proc_open"/g' ${PHP_INI} \
    && sed -i 's/max_execution_time = 30/max_execution_time = 300/g' ${PHP_INI} \
    && sed -i 's/;max_input_vars = 1000/max_input_vars = 10000/g' ${PHP_INI} \
    && sed -i 's/max_input_time = 60/max_input_time = 300/g' ${PHP_INI} \
    && sed -i 's/memory_limit = 128M/memory_limit = 256M/g' ${PHP_INI} \
    && sed -i 's/post_max_size = 8M/post_max_size = 100M/g' ${PHP_INI} \
    && sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 100M/g' ${PHP_INI} \
    && sed -i 's/;session.save_path = "\/tmp"/session.save_path = "\/tmp"/g' ${PHP_INI} \
    && sed -i 's/;date.timezone =/date.timezone = "UTC"/g' ${PHP_INI} \
    # Opcache
    && sed -i 's/;opcache.enable=1/opcache.enable=1/g' ${PHP_INI} \
    && sed -i 's/;opcache.memory_consumption=128/opcache.memory_consumption=256/g' ${PHP_INI} \
    && sed -i 's/;opcache.use_cwd=1/opcache.use_cwd=0/g' ${PHP_INI} \
    && sed -i 's/;opcache.max_file_size=0/opcache.max_file_size=0/g' ${PHP_INI} \
    && sed -i 's/;opcache.max_accelerated_files=10000/opcache.max_accelerated_files=30000/g' ${PHP_INI} \
    && sed -i 's/;opcache.validate_timestamps=1/opcache.validate_timestamps=1/g' ${PHP_INI} \
    && sed -i 's/;opcache.revalidate_freq=2/opcache.revalidate_freq=0/g' ${PHP_INI} 


# Cleaning up
RUN rm -rf /tmp/* \
    && rm -rf /var/cache/apk/* 
