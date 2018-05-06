#!/usr/bin/env bash

case $php_version in
     5.6.30)

        git clone git://github.com/swoole/swoole-src.git
        cd swoole-src/
        git checkout v1.7.6
        /data/server/php/bin/phpize
        ./configure --with-php-config=$install_dir/server/php/bin/php-config &&
        make && make install
        echo 'extension=swoole.so' >> /data/server/php/etc/php.ini
        cd ..
        ;;
     7.1.3)
        git clone git://github.com/swoole/swoole-src.git
        cd swoole-src/
        git checkout v2.0.5
        /data/server/php/bin/phpize
        ./configure --with-php-config=$install_dir/server/php/bin/php-config &&
        make && make install
        echo 'extension=swoole.so' >> /data/server/php/etc/php.ini
        cd ..
        ;;
esac



