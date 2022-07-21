# #############################################################################
# Original PHP-FPM Alpine version
# #############################################################################
FROM php:7.4-fpm-alpine

ENV image_version="1.0"
ENV PHP_VERSION=7.4
ENV COMPOSER_VERSION=2.3.7

LABEL maintainer="me@ShGoudarzi.ir" \
    version=${image_version} \
    description="Original PHP-FPM Alpine version + Most useful PHP extensions + Apply Basic configuration"


# #############################################################################
#  Useful PHP extensions 
# #############################################################################
ENV BUILD_DEPENDENSIES="autoconf g++ libtool make pcre-dev"
ENV DEPENDENSIES="bash \
    freetype \
    gettext-dev \
    git \
    icu-dev \
    imagemagick-dev \
    libgd \
    bzip2-dev \
    libjpeg-turbo \
    libpng-dev \
    libxml2-dev \
    libzip-dev \
    libxslt-dev \
    postgresql-dev \
    tidyhtml-dev"

ENV EXTENSIONS_NEED_CONFIG="intl "
ENV EXTENSIONS_NEED_PECL="imagick redis "

ENV EXTENSIONS="bcmath \
    bz2 \
    calendar \
    exif \
    gd \
    gettext \
    intl \
    mysqli \
    opcache \
    pcntl \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    soap \
    sockets \
    tidy \
    xml \
    xsl \
    zip"


# Base Installation
RUN apk update && apk upgrade \
    && apk add --no-cache --virtual .build-deps ${PHPIZE_DEPS} ${BUILD_DEPENDENSIES} \
    && apk add --no-cache ${DEPENDENSIES} \
    && docker-php-ext-configure ${EXTENSIONS_NEED_CONFIG} \
    && docker-php-ext-install ${EXTENSIONS} \
    && pecl install ${EXTENSIONS_NEED_PECL} \
    && docker-php-ext-enable ${EXTENSIONS_NEED_PECL} 

# IonCube Loader Installation
ARG INSTALL_IONCUBE=true
RUN if [ ${INSTALL_IONCUBE} = true ]; then \
    curl -L -o /tmp/ioncube_loaders_lin_x86-64.tar.gz https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz \
    && tar zxpf /tmp/ioncube_loaders_lin_x86-64.tar.gz -C /tmp \
    && mv /tmp/ioncube/ioncube_loader_lin_${PHP_VERSION}.so $(php -r "echo ini_get('extension_dir');")/ioncube_loader.so \
    && printf "zend_extension=ioncube_loader.so\n" > $PHP_INI_DIR/conf.d/0ioncube.ini \
    && rm -rf /tmp/ioncube* \
;fi


# Composer Installation
ARG INSTALL_COMPOSER=true
RUN if [ ${INSTALL_COMPOSER} = true ]; then \
    mkdir /etc/composer \
    && wget https://getcomposer.org/installer -P /etc/composer \
    && cd /etc/composer && php ./installer  --filename=composer --verion=${COMPOSER_VERSION} --install-dir=/bin \
    && rm /etc/composer/installer \
    && chmod a+x /bin/composer \
;fi


# SourceGuardian Loader Installation
ARG INSTALL_SOURCE_GUARDIAN=true
RUN if [ ${INSTALL_SOURCE_GUARDIAN} = true ]; then \
    mkdir -p /tmp/sourceguardian \
    && cd /tmp/sourceguardian \
    && curl -Os https://www.sourceguardian.com/loaders/download/loaders.linux-x86_64.tar.gz \
    && tar xzf loaders.linux-x86_64.tar.gz \
    && cp ixed.${PHP_VERSION}.lin "$(php -i | grep '^extension_dir =' | cut -d' ' -f3)/sourceguardian.so" \
    && echo "extension=sourceguardian.so" > /usr/local/etc/php/conf.d/15-sourceguardian.ini \
    && rm -rf /tmp/sourceguardian \
;fi


# #############################################################################
# Apply Basic configuration
# #############################################################################
ENV PHP_INI=$PHP_INI_DIR/php.ini
RUN rm -f $PHP_INI_DIR/php.ini-development && mv $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini \
    && sed -i 's/short_open_tag = Off/short_open_tag = On/g' ${PHP_INI} \
    && sed -i 's/disable_functions =/disable_functions = "show_source, system, shell_exec, passthru, exec, popen, proc_open"/g' ${PHP_INI} \
    && sed -i 's/max_execution_time = 30/max_execution_time = 180/g' ${PHP_INI} \
    && sed -i 's/;max_input_vars = 1000/max_input_vars = 10000/g' ${PHP_INI} \
    && sed -i 's/max_input_time = 60/max_input_time = 120/g' ${PHP_INI} \
    && sed -i 's/memory_limit = 128M/memory_limit = 256M/g' ${PHP_INI} \
    && sed -i 's/post_max_size = 8M/post_max_size = 100M/g' ${PHP_INI} \
    && sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 100M/g' ${PHP_INI} \
    && sed -i 's/;date.timezone =/date.timezone = "UTC"/g' ${PHP_INI}


# Cleaning up
RUN apk del .build-deps \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/* 


