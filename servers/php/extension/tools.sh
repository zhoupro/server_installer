#!/usr/bin/env bash

PHP_VERSION=$SERVER_VERSION
php_version=`expr "$PHP_VERSION" : "^\([0-9]*\.[0-9]*\)\.[0-9]*"`
case $php_version in
     5.3|5.4|5.5|5.6|7.0|7.1|7.2)
         composer global require "squizlabs/php_codesniffer=*" -vvv
         composer global require "phpmd/phpmd=*" -vvv
         composer global require "friendsofphp/php-cs-fixer=*" -vvv
         echo "export PATH=\$PATH:$HOME/.composer/vendor/bin" >> $HOME/.env
        ;;
esac



