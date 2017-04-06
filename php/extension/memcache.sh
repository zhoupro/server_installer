#!/usr/bin/env bash
case $php_version in
     5.3.29)
        #memcache
        if [ ! -f memcache-3.0.6.tgz ];then
            wget http://oss.aliyuncs.com/aliyunecs/onekey/php_extend/memcache-3.0.6.tgz
        fi
        rm -rf memcache-3.0.6
        tar -xzvf memcache-3.0.6.tgz
        cd memcache-3.0.6
        $install_dir/server/php/bin/phpize
        ./configure --enable-memcache --with-php-config=$install_dir/server/php/bin/php-config
        CPU_NUM=$(cat /proc/cpuinfo | grep processor | wc -l)
        if [ $CPU_NUM -gt 1 ];then
            make -j$CPU_NUM
        else
            make
        fi
        make install
        cd ..
        echo "extension=memcache.so" >> $install_dir/server/php/etc/php.ini


        #libmemcache
        if [ ! -f libmemcached-1.0.16.tar.gz ];then
            wget https://launchpad.net/libmemcached/1.0/1.0.16/+download/libmemcached-1.0.16.tar.gz
        fi
        rm -rf libmemcached-1.0.16
        tar xzvf  libmemcached-1.0.16.tar.gz
        cd libmemcached-1.0.16
        $install_dir/server/php/bin/phpize
        ./configure  --prefix=/usr/local/libmemcached
        make
        make install
        cd ..

        #memcached
        if [ ! -f REL2_0.zip ];then
            wget https://github.com/php-memcached-dev/php-memcached/archive/REL2_0.zip
        fi
        rm -rf php-memcached-REL2_0
        unzip REL2_0.zip
        cd php-memcached-REL2_0
        $install_dir/server/php/bin/phpize
        ./configure  --with-php-config=$install_dir/server/php/bin/php-config  --with-libmemcached-dir=/usr/local/libmemcached --disable-memcached-sasl
        make
        make install
        cd ..
        echo "extension=memcached.so" >> $install_dir/server/php/etc/php.ini
        ;;
esac

