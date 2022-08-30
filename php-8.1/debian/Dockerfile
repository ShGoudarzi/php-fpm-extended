# #############################################################################
# Original PHP-FPM 
# #############################################################################
FROM php:8.1-fpm

ENV image_version="1.0"
ENV PHP_VERSION=8.1

LABEL maintainer="me@ShGoudarzi.ir" \
    version=${image_version} \
    description="Original PHP-FPM + Useful PHP extensions + Apply Basic configuration"


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
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
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
    && sed -i 's/short_open_tag.*/short_open_tag = On/g' ${PHP_INI} \
    && sed -i 's/disable_functions.*/disable_functions = "show_source, system, shell_exec, passthru, exec, popen, proc_open"/g' ${PHP_INI} \
    && sed -i 's/max_execution_time.*/max_execution_time = 300/g' ${PHP_INI} \
    && sed -i 's/;max_input_vars.*/max_input_vars = 10000/g' ${PHP_INI} \
    && sed -i 's/max_input_time.*/max_input_time = 300/g' ${PHP_INI} \
    && sed -i 's/memory_limit.*/memory_limit = 256M/g' ${PHP_INI} \
    && sed -i 's/post_max_size.*/post_max_size = 100M/g' ${PHP_INI} \
    && sed -i 's/upload_max_filesize.*/upload_max_filesize = 100M/g' ${PHP_INI} \
    && sed -i 's/;session.save_path.*/session.save_path = "\/tmp"/g' ${PHP_INI} \
    && sed -i 's/;date.timezone.*/date.timezone = "UTC"/g' ${PHP_INI} \
    # Opcache
    && sed -i 's/;opcache.enable.*/opcache.enable=1/g' ${PHP_INI} \
    && sed -i 's/;opcache.memory_consumption.*/opcache.memory_consumption=256/g' ${PHP_INI} \
    && sed -i 's/;opcache.use_cwd.*/opcache.use_cwd=0/g' ${PHP_INI} \
    && sed -i 's/;opcache.max_file_size.*/opcache.max_file_size=0/g' ${PHP_INI} \
    && sed -i 's/;opcache.max_accelerated_files.*/opcache.max_accelerated_files=30000/g' ${PHP_INI} \
    && sed -i 's/;opcache.validate_timestamps.*/opcache.validate_timestamps=1/g' ${PHP_INI} \
    && sed -i 's/;opcache.revalidate_freq.*/opcache.revalidate_freq=0/g' ${PHP_INI} 


# Cleaning up
RUN apt-get remove --purge -y build-essential && apt-get autoclean && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm /var/log/lastlog /var/log/faillog
