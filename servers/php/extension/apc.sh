#!/usr/bin/env bash


case $php_version in
     5.3.29)
        if [ ! -f APC-3.1.9.tgz ];then
            wget http://pecl.php.net/get/APC-3.1.9.tgz
        fi
        rm -rf APC-3.1.9
        tar zxvf APC-3.1.9.tgz
        cd APC-3.1.9
        $install_dir/server/php/bin/phpize
        CFLAGS="-O3" ./configure -with-php-config=$install_dir/server/php/bin/php-config --enable-apc
        make
        make install
        cd ..
        cat >> $install_dir/server/php/etc/php.ini <<END
[apc]
extension= apc.so
apc.enabled = 1
apc.cache_by_default = on
apc.shm_segments = 1
apc.shm_size = 32M
apc.ttl = 7200
apc.user_ttl = 7200
apc.num_files_hint = 0
apc.write_lock = on
END
        ;;
esac




