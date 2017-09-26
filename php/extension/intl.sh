#!/usr/bin/env bash

case $php_version in
     5.4.23|5.5.38|5.6.30|7.0.23|7.1.3)
        # icu
        wget http://download.icu-project.org/files/icu4c/52.1/icu4c-52_1-src.tgz
        tar xf icu4c-52_1-src.tgz
        cd icu/source
        mkdir /usr/local/icu
        ./configure --prefix=/usr/local/icu
        make && make install
        cd ../..

        # intl

        wget http://pecl.php.net/get/intl-3.0.0.tgz
        tar -xzf intl-3.0.0.tgz
        cd intl-3.0.0
        ./configure --enable-intl --with-icu-dir=/usr/local/icu/ --with-php-config=$install_dir/server/php/bin/php-config
        make
        make install
        cd ..
        echo "extension=intl.so" >> $install_dir/server/php/etc/php.ini
        ;;


esac


