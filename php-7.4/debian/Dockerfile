# #############################################################################
# Original PHP-FPM 
# #############################################################################
FROM php:7.4-fpm

ENV PHP_VERSION=7.4
ENV image_version="v$PHP_VERSION"
ENV COMPOSER_VERSION=2.4.0

LABEL maintainer="https://github.com/ShGoudarzi" \
    version=${image_version} \
    description="Original PHP-FPM + Useful PHP extensions + Apply Basic configuration"

 
# #############################################################################
#  Useful PHP extensions 
# #############################################################################
ENV BUILD_DEPENDENSIES="autoconf g++ gcc make libtool libc-dev pkg-config"  
ENV DEPENDENSIES=" iputils-ping \ 
    curl wget vim git \ 
    libmemcached-dev \
    libc-client-dev libkrb5-dev \
    libz-dev \
    libpq-dev \
    libssl-dev libssl-doc libsasl2-dev \
	  libmcrypt-dev \
	  libxml2-dev \
	  zlib1g-dev libicu-dev \
	  libbz2-dev \
	  libcurl4-openssl-dev \
	  libgmp-dev libib-util \
    libpng++-dev \
	  libwebp-dev libjpeg-dev libjpeg62-turbo-dev libpng-dev libfreetype6-dev \
	  libmagick++-dev libmagickwand-dev libmagic-dev \
	  libgd-dev \
	  libtidy-dev libxslt1-dev libexif-dev \
	  libxslt-dev \
	  libmhash2 libmhash-dev \
	  libpcre3 libpcre3-dev \
	  libsodium-dev \
	  libonig-dev \
    libzip-dev  "


ENV EXTENSIONS_NEED_PECL="imagick redis mongodb memcached "

ENV EXTENSIONS="bcmath \
    bz2 \
    calendar \
    curl \
    dba \
    exif \
    mbstring \
    gd \
    gmp \
    gettext \
    fileinfo \
    ftp \
    intl \
    imap \
    mysqli \
    opcache \
    pcntl \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    soap \
    sodium \
    sockets \
    tidy \
    xmlrpc \
    xml \
    xsl \
    zip "


# Base Installation
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get -y install ${BUILD_DEPENDENSIES} \
    && apt-get install -y --no-install-recommends ${DEPENDENSIES} \
    # Configure
    && docker-php-ext-configure intl \
    && docker-php-ext-configure gd --prefix=/usr --with-jpeg --with-webp --with-freetype \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    # Core Install
    && docker-php-ext-install ${EXTENSIONS} \
    # PECL
    && pecl install ${EXTENSIONS_NEED_PECL} \
    && docker-php-ext-enable ${EXTENSIONS_NEED_PECL} 


# IonCube Loader Installation
ARG INSTALL_IONCUBE=true
RUN if [ ${INSTALL_IONCUBE} = true ]; then \
    curl -L -o /tmp/ioncube_loaders_lin_x86-64.tar.gz https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz \
    && tar zxpf /tmp/ioncube_loaders_lin_x86-64.tar.gz -C /tmp \
    && mv /tmp/ioncube/ioncube_loader_lin_${PHP_VERSION}.so $(php -r "echo ini_get('extension_dir');")/ioncube_loader.so \
    && printf "zend_extension=ioncube_loader.so\n" > $PHP_INI_DIR/conf.d/0ioncube.ini \
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
;fi


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
RUN apt-get remove --purge -y build-essential ${BUILD_DEPENDENSIES} && apt-get autoclean && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm /var/log/lastlog /var/log/faillog



