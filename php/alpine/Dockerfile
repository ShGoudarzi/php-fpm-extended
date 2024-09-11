# #############################################################################
# Dynamic PHP-FPM Alpine with Optimizations and Unrooted User (UID 1001)
# #############################################################################
# Allow customization of PHP version
ARG PHP_VERSION=7.4

FROM php:${PHP_VERSION}-fpm-alpine

# Metadata
ENV image_version="1.3"
LABEL maintainer="me@ShGoudarzi.ir" \
      version=${image_version} \
      description="Optimized PHP-FPM Alpine (Unrooted, UID=1001) with dynamic PHP version + Useful PHP extensions + Basic configurations"

# #############################################################################
#  Install Useful PHP Extensions
# #############################################################################
# Defining necessary PHP extensions
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

# Install PHP extensions and clean up in a single RUN layer
RUN set -eux; \
    apk update && apk upgrade --no-cache && \
    apk add --no-cache --virtual .build-deps $PHPIZE_DEPS shadow \
    && curl -sSLf -o /usr/local/bin/install-php-extensions \
    https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions \
    && chmod +x /usr/local/bin/install-php-extensions \
    && install-php-extensions ${EXTENSIONS} \
    # Remove build dependencies and clean up
    && apk del --no-cache .build-deps \
    && rm -rf /tmp/* /var/cache/apk/*

# #############################################################################
# Create a Non-Root User (UID 1001) and Set Permissions
# #############################################################################
# Add a non-root user `appuser` with UID 1001 and group `appgroup` with GID 1001
###  RUN set -eux; \
###      addgroup -g 1001 appgroup && \
###      adduser -D -u 1001 -G appgroup -h /home/appuser -s /bin/sh appuser && \
###      mkdir -p /var/www/html && \
###      chown -R appuser:appgroup /var/www/html && \
###      chown -R appuser:appgroup /var/tmp && \
###      chown -R appuser:appgroup /tmp && \
###      chown -R appuser:appgroup /usr/local/etc/php/conf.d/ && \
###      chown -R appuser:appgroup /home/appuser

# #############################################################################
# Apply Basic PHP Configurations
# #############################################################################
ENV PHP_INI=$PHP_INI_DIR/php.ini

# Configure PHP and Opcache
RUN set -eux; \
    rm -f $PHP_INI_DIR/php.ini-development && mv $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini \
    # General PHP configurations
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
    # Opcache configurations
    && sed -i 's/;opcache.enable.*/opcache.enable=1/g' ${PHP_INI} \
    && sed -i 's/;opcache.memory_consumption.*/opcache.memory_consumption=256/g' ${PHP_INI} \
    && sed -i 's/;opcache.max_accelerated_files.*/opcache.max_accelerated_files=30000/g' ${PHP_INI} \
    && sed -i 's/;opcache.validate_timestamps.*/opcache.validate_timestamps=1/g' ${PHP_INI} \
    && sed -i 's/;opcache.revalidate_freq.*/opcache.revalidate_freq=0/g' ${PHP_INI}

# #############################################################################
# Switch to Non-Root User (UID 1001) and Start PHP-FPM
# #############################################################################
# Switch to non-root user `appuser` with UID 1001
###  USER appuser

# Set the working directory
###  WORKDIR /var/www/html

# Expose port 9000 for PHP-FPM
###  EXPOSE 9000

# Command to run PHP-FPM
###  CMD ["php-fpm"]
