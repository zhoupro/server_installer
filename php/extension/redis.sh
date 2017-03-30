#!/usr/bin/env bash

if [ ! -f master.zip ];then
    wget https://github.com/phpredis/phpredis/archive/master.zip
fi
rm -rf phpredis-master
unzip master.zip
cd phpredis-master
$install_dir/server/php/bin/phpize
./configure --enable-memcache --with-php-config=$install_dir/server/php/bin/php-config
make
make install
cd ..
echo "extension=redis.so" >> $install_dir/server/php/etc/php.ini
