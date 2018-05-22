#!/usr/bin/env bash
PHP_VERSION=$SERVER_VERSION
php_version=`expr "$PHP_VERSION" : "^\([0-9]*\.[0-9]*\)\.[0-9]*"`

case $php_version in
     7.1|7.2)
        git clone git://github.com/swoole/swoole-src.git
        cd swoole-src/
        git checkout v2.0.5
        $BASE_DIR/server/php/bin/phpize
        ./configure --with-php-config=$BASE_DIR/server/php/bin/php-config &&
        make && make install
        echo 'extension=swoole.so' >> $BASE_DIR/server/php/etc/php.ini
        cd ..
        ;;
esac
