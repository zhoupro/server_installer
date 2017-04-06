#!/usr/bin/env bash

case $php_version in
     5.3.29|5.6.30|7.1.3)
        git clone git://github.com/phpredis/phpredis.git
        cd phpredis
        git checkout 3.1.2
        $install_dir/server/php/bin/phpize
        ./configure --enable-memcache --with-php-config=$install_dir/server/php/bin/php-config
        make
        make install
        cd ..
        echo "extension=redis.so" >> $install_dir/server/php/etc/php.ini
        ;;


esac


