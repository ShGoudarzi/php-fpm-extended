# PHP-FPM Extended 
PHP-FPM Original Docker image + Useful PHP extensions + Apply Basic configuration

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

```
git clone https://github.com/ShGoudarzi/php-fpm-extended.git
cd php-fpm-extended
cd alpine
```


### 1. Simple way - default configuration
`docker-compose up -d` 


### 2. Advanced way - custom configuration

Build temp image and copy the container php.ini file to the host ( if this is the first time)
```
docker build -t custom-php-fpm .
docker run --name temp-php-container --rm -d custom-php-fpm
docker cp temp-php-container:/usr/local/etc/php/php.ini ./php.ini
docker stop temp-php-container
```

uncomment line 15 from docker-compose.yml and `docker-compose up -d`

----------------------------------------------------------------------------------------------------------
## Additional
https://github.com/rlerdorf/opcache-status


