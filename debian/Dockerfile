# #############################################################################
# Original PHP-FPM with Multi-PHP Version Support
# #############################################################################

# Use ARG to define the PHP version, with 7.4 as the default
ARG PHP_VERSION=7.4
FROM php:${PHP_VERSION}-fpm

# General metadata
ENV image_version="1.0"
LABEL maintainer="me@ShayanGoudarzi.ir" \
      version=${image_version} \
      description="PHP-FPM with support for multiple PHP versions + Useful PHP extensions + Basic configuration"

# #############################################################################
# Useful PHP extensions
# #############################################################################
ENV EXTENSIONS="bcmath bz2 calendar dba exif gd gettext gmp imagick imap intl \
                ioncube_loader memcache memcached mysqli odbc opcache pcntl \
                pdo_mysql pdo_odbc pdo_pgsql pgsql redis soap sockets \
                sourceguardian tidy timezonedb xmlrpc xsl zip"

# Set non-interactive mode for package installation
ENV DEBIAN_FRONTEND=noninteractive

# #############################################################################
# Base Installation
# #############################################################################
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       libfreetype6-dev libjpeg62-turbo-dev libpng-dev libwebp-dev libxpm-dev \
       libbz2-dev libcurl4-openssl-dev libgmp-dev libicu-dev libmagickwand-dev \
       libmemcached-dev libpq-dev libxml2-dev zlib1g-dev libxslt1-dev git curl unzip \
    && curl -sSLf -o /usr/local/bin/install-php-extensions \
        https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions \
    && chmod +x /usr/local/bin/install-php-extensions \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp --with-xpm \
    && install-php-extensions ${EXTENSIONS} \
    # Install PECL extensions
    && pecl install redis imagick memcached \
    && docker-php-ext-enable redis imagick memcached \
    # Clean up unnecessary files
    && apt-get remove --purge -y build-essential \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archives/* \
    && rm /var/log/lastlog /var/log/faillog

# #############################################################################
# Apply Basic PHP Configuration
# #############################################################################
ENV PHP_INI=$PHP_INI_DIR/php.ini

RUN cp $PHP_INI_DIR/php.ini-production $PHP_INI \
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
    # Opcache settings
    && sed -i 's/;opcache.enable.*/opcache.enable=1/g' $PHP_INI \
    && sed -i 's/;opcache.memory_consumption.*/opcache.memory_consumption=256/g' $PHP_INI \
    && sed -i 's/;opcache.use_cwd.*/opcache.use_cwd=0/g' $PHP_INI \
    && sed -i 's/;opcache.max_accelerated_files.*/opcache.max_accelerated_files=30000/g' $PHP_INI \
    && sed -i 's/;opcache.validate_timestamps.*/opcache.validate_timestamps=1/g' $PHP_INI \
    && sed -i 's/;opcache.revalidate_freq.*/opcache.revalidate_freq=0/g' $PHP_INI

# #############################################################################
# User Management
# #############################################################################
###  RUN useradd -u 1001 -s /sbin/nologin -c "Safe-Container-User" -M scu \
###      && mkdir -p /var/www/html /tmp \
###      && chown -R scu:scu /var/www/html /tmp

# Switch to non-root user for security
###  USER scu

# Set working directory
###  WORKDIR /var/www/html

# Expose port for PHP-FPM
###  EXPOSE 9000

# Command to start PHP-FPM
###  CMD ["php-fpm"]
