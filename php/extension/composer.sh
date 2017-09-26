#!/usr/bin/env bash


case $php_version in
     5.3.29|5.4.23|5.5.38|5.6.30|7.0.23|7.1.3)
       #install composer
        wget --no-check-certificate  "https://github.com/composer/composer/releases/download/1.5.2/composer.phar" && mv composer.phar /usr/local/bin/composer
        chmod 777 -R /usr/local/bin/composer
        ;;
esac



