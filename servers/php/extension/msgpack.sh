#!/usr/bin/env bash

case $php_version in
     *)
        git clone https://github.com/msgpack/msgpack-php.git 
        cd msgpack-php 
        git checkout msgpack-2.0.2 
        $BASE_DIR/server/php/bin/phpize
        ./configure  --with-php-config=$BASE_DIR/server/php/bin/php-config
        make
        make install
        cd ..
        echo "extension=msgpack.so" >> $BASE_DIR/server/php/etc/php.ini
        ;;
esac


