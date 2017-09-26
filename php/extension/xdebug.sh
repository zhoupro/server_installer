#!/usr/bin/env bash


extension_dir=`/data/server/php/bin/php-config --extension-dir`
case $php_version in
     5.3.29)
        git clone git://github.com/xdebug/xdebug.git
        cd xdebug/
        git checkout XDEBUG_2_2_1
        ;;

     5.4.23)
        git clone git://github.com/xdebug/xdebug.git
        cd xdebug/
        git checkout XDEBUG_2_2_1
        ;;

     5.5.38|5.6.30|7.0.23|7.1.3)
        git clone git://github.com/xdebug/xdebug.git
        cd xdebug/
        git checkout XDEBUG_2_5_1
        ;;
esac

if [  -d ../xdebug ];then
	 /data/server/php/bin/phpize
    ./configure --with-php-config=$install_dir/server/php/bin/php-config &&
    make && make install
    echo "zend_extension=${extension_dir}/xdebug.so" >> /data/server/php/etc/php.ini
    echo 'xdebug.remote_enable=1 ' >> /data/server/php/etc/php.ini &&  \
    echo 'xdebug.remote_autostart=1' >> /data/server/php/etc/php.ini &&   \
    echo 'xdebug.remote_connect_back=1' >> /data/server/php/etc/php.ini && \
    echo 'xdebug.remote_handler=dbgp' >> /data/server/php/etc/php.ini && \
    echo 'xdebug.remote_port=9000' >> /data/server/php/etc/php.ini && \
    echo 'xdebug.idekey=PHPSTORM' >> /data/server/php/etc/php.ini
    cd ..
fi




