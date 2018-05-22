#!/usr/bin/env bash
PHP_VERSION=$SERVER_VERSION
php_version=`expr "$PHP_VERSION" : "^\([0-9]*\.[0-9]*\)\.[0-9]*"`

case $php_version in
     5.3|5.4|5.5)
        #install phpunit
        wget --no-check-certificate  "https://phar.phpunit.de/phpunit-4.8.phar" && mv phpunit-4.8.phar /usr/local/bin/phpunit
        chmod 777 -R /usr/local/bin/phpunit
        ;;
     5.6)
        #install phpunit
        wget --no-check-certificate  "https://phar.phpunit.de/phpunit-5.7.phar" && mv phpunit-5.7.phar /usr/local/bin/phpunit
        chmod 777 -R /usr/local/bin/phpunit
        ;;

     7.0|7.1|7.2)
         #install phpunit
        wget --no-check-certificate  "https://phar.phpunit.de/phpunit-6.4.phar" && mv phpunit-6.4.phar /usr/local/bin/phpunit
        chmod 777 -R /usr/local/bin/phpunit
        ;;
esac
