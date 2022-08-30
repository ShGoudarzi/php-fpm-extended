# PHP-FPM Extended 
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


Install docker, docker compose

https://docs.docker.com/engine/install/


## Deployment

Copy the `docker-compose.yml` template into your project folder and start the container ( `docker compose -f docker-compose.yml up -d` ):

```
version: '3.9'
services:
  #PHP Service
  php74-fpm:
    image: shgoudarzi/php-fpm-extended:latest    # ( replace with with your own version want )
    container_name: php-fpm
    restart: unless-stopped
    tty: true
#    ports:
#      - "9000:9000"
    volumes:
      #sites - working dir ( both side must be the same as root path of webserver conf like Nginx )
      - /home/web:/usr/share/nginx/html
      #Conf files
#      - /local/path/to/php.ini:/usr/local/etc/php/php.ini
#      - /local/path/to/www.conf:/usr/local/etc/php-fpm.d/www.conf
    environment:
      - TZ="Asia/Tehran"
```


or

```
docker run -d \
    --name=php-fpm \
    -v /home/web:/usr/share/nginx/html \
    -p 9000:9000 \
    --restart unless-stopped \
    shgoudarzi/php-fpm-extended:latest
```

