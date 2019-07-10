#!/usr/bin/env bash

PHP_VERSION=$SERVER_VERSION
php_version=`expr "$PHP_VERSION" : "^\([0-9]*\.[0-9]*\)\.[0-9]*"`
case $php_version in
     5.3|5.4|5.5|5.6)
       #install composer
        wget --no-check-certificate  "https://github.com/composer/composer/releases/download/1.5.2/composer.phar" && mv composer.phar /usr/local/bin/composer
        chmod 777 -R /usr/local/bin/composer
        ;;
     7.0|7.1|7.2)
       #install composer
        wget --no-check-certificate  "https://github.com/composer/composer/releases/download/1.8.6/composer.phar" && mv composer.phar /usr/local/bin/composer
        chmod 777 -R /usr/local/bin/composer
        ;;
esac
#use aliyun mirrors
composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/




