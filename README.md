# PHP-FPM Alpine Extended 
Original PHP-FPM Alpine version + Most useful PHP extensions + Apply Basic configuration

included:

+ ### Pure PHP Extentions:
`bcmath`
`bz2`
`calendar`
`Core`
`ctype`
`curl`
`date`
`dom`
`exif`
`fileinfo`
`filter`
`ftp`
`gd`
`gettext`
`hash`
`iconv`
`intl`
`json`
`libxml`
`mbstring`
`mysqli`
`mysqlnd`
`openssl`
`pcntl`
`pcre`
`PDO`
`pdo_mysql`
`pdo_pgsql`
`pdo_sqlite`
`pgsql`
`Phar`
`posix`
`readline`
`redis`
`Reflection`
`session`
`SimpleXML`
`soap`
`sockets`
`sodium`
`SPL`
`sqlite3`
`standard`
`tidy`
`tokenizer`
`xml`
`xmlreader`
`xmlwriter`
`xsl`
`Zend OPcache`
`zip`
`zlib`

+ ### Popular usefull PHP Modules:

`Composer`
`ionCube Loader`
`SourceGuardian`


# Installation

## Deployment

Copy the `docker-compose.yml` template into your project folder and start the container.

or

```
docker run -d \
    --name=php74-fpm \
    -v /home/web:/usr/share/nginx/html \
    -p 9000:9000 \
    --restart unless-stopped \
    shgoudarzi/php-fpm-alpine-extended:7.4
```

