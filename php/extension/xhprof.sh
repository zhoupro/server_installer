#!/usr/bin/env bash


case $php_version in
     5.3.29)

        #xhprof
        if [ ! -f xhprof-0.9.4.tgz ];then
            wget http://pecl.php.net/get/xhprof-0.9.4.tgz
        fi
        rm -rf xhprof-0.9.4
        tar -zxvf xhprof-0.9.4.tgz
        cd xhprof-0.9.4/extension
        $install_dir/server/php/bin/phpize
        ./configure --with-php-config=$install_dir/server/php/bin/php-config
        make
        make install
        cd ../..
        cat >> $install_dir/server/php/etc/php.ini <<END
[xhprof]
extension=xhprof.so
xhprof.output_dir=/tmp
END
        ;;
esac


