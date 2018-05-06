#!/usr/bin/env bash

case $php_version in


     5.3.29|5.4.23|5.5.38)

        #install phpunit
        wget --no-check-certificate  "https://phar.phpunit.de/phpunit-4.8.phar" && mv phpunit-4.8.phar /usr/local/bin/phpunit
        chmod 777 -R /usr/local/bin/phpunit
        ;;

     5.6.30)
        #install phpunit
        wget --no-check-certificate  "https://phar.phpunit.de/phpunit-5.7.phar" && mv phpunit-5.7.phar /usr/local/bin/phpunit
        chmod 777 -R /usr/local/bin/phpunit
        ;;

     7.0.23|7.1.3)
         #install phpunit
        wget --no-check-certificate  "https://phar.phpunit.de/phpunit-6.4.phar" && mv phpunit-6.4.phar /usr/local/bin/phpunit
        chmod 777 -R /usr/local/bin/phpunit
        ;;
esac



