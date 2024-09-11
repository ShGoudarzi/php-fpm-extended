# #############################################################################
# PHP-FPM Debian-based (Bitnami) + Non-root Setup with PHP Version ARG
# #############################################################################
ARG PHP_VERSION=7.4
FROM bitnami/php-fpm:${PHP_VERSION}

# Metadata
ARG image_version="1.1"
LABEL maintainer="me@ShayanGoudarzi.ir" \
    version=${image_version} \
    description="Optimized PHP-FPM with Useful Extensions and Security (Non-root, UID 1001), PHP Version ARG"

# #############################################################################
# Install Useful PHP Extensions
# #############################################################################
ENV DEBIAN_FRONTEND=noninteractive
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
    redis \
    soap \
    sockets \
    sourceguardian \
    tidy \
    timezonedb \
    xmlrpc \
    xsl \
    zip"

# Temporarily switch to root to install dependencies and PHP extensions
USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl git unzip \
    && curl -sSLf -o /usr/local/bin/install-php-extensions \
    https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions \
    && chmod +x /usr/local/bin/install-php-extensions \
    && install-php-extensions ${EXTENSIONS} \
    # Clean up unnecessary packages and temporary files
    && apt-get remove --purge -y build-essential \
    && apt-get autoremove -y && apt-get autoclean && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archives/* \
    && rm -f /var/log/lastlog /var/log/faillog

# #############################################################################
# Basic PHP Configuration
# #############################################################################
ENV PHP_INI=/opt/bitnami/php/etc/php.ini

RUN mv /opt/bitnami/php/etc/php.ini-production $PHP_INI \
    # General PHP settings
    && sed -i 's/short_open_tag.*/short_open_tag = On/g' $PHP_INI \
    && sed -i 's/disable_functions.*/disable_functions = "show_source, system, shell_exec, passthru, exec, popen, proc_open"/g' $PHP_INI \
    && sed -i 's/max_execution_time.*/max_execution_time = 300/g' $PHP_INI \
    && sed -i 's/;max_input_vars.*/max_input_vars = 10000/g' $PHP_INI \
    && sed -i 's/max_input_time.*/max_input_time = 300/g' $PHP_INI \
    && sed -i 's/memory_limit.*/memory_limit = 256M/g' $PHP_INI \
    && sed -i 's/post_max_size.*/post_max_size = 100M/g' $PHP_INI \
    && sed -i 's/upload_max_filesize.*/upload_max_filesize = 100M/g' $PHP_INI \
    && sed -i 's/;session.save_path.*/session.save_path = "\/tmp"/g' $PHP_INI \
    && sed -i 's/;date.timezone.*/date.timezone = "UTC"/g' $PHP_INI \
    # Opcache settings for performance
    && sed -i 's/;opcache.enable.*/opcache.enable=1/g' $PHP_INI \
    && sed -i 's/;opcache.memory_consumption.*/opcache.memory_consumption=256/g' $PHP_INI \
    && sed -i 's/;opcache.max_accelerated_files.*/opcache.max_accelerated_files=30000/g' $PHP_INI \
    && sed -i 's/;opcache.validate_timestamps.*/opcache.validate_timestamps=1/g' $PHP_INI \
    && sed -i 's/;opcache.revalidate_freq.*/opcache.revalidate_freq=0/g' $PHP_INI

# #############################################################################
# User Management
# #############################################################################
# Add a non-root user `scu` with UID 1001 and ensure correct permissions
###  RUN useradd -u 1001 -s /usr/sbin/nologin -c "Safe-Container-User" -M scu \
###      && mkdir -p /var/www/html /tmp \
###      && chown -R scu:scu /var/www/html /tmp

# Switch to non-root user `scu`
###  USER scu

# #############################################################################
# Final Configuration and Runtime
# #############################################################################
# Set working directory to document root
###  WORKDIR /var/www/html

# Expose PHP-FPM default port
###  EXPOSE 9000

# Start PHP-FPM as the entrypoint
###  CMD ["php-fpm"]
