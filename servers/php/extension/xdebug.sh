#!/usr/bin/env bash
PHP_VERSION=$SERVER_VERSION
php_version=`expr "$PHP_VERSION" : "^\([0-9]*\.[0-9]*\)\.[0-9]*"`

extension_dir=`$BASE_DIR/server/php/bin/php-config --extension-dir`
case $php_version in
     5.3|5.4)
        git clone git://github.com/xdebug/xdebug.git
        cd xdebug/
        git checkout XDEBUG_2_2_1
        ;;


     5.5|5.6|7.0|7.1)
        git clone git://github.com/xdebug/xdebug.git
        cd xdebug/
        git checkout XDEBUG_2_5_1
        ;;
     7.2)
        git clone git://github.com/xdebug/xdebug.git
        cd xdebug/
        git checkout XDEBUG_2_6_0
        ;;
esac

if [  -d ../xdebug ];then
	 $BASE_DIR/server/php/bin/phpize
    ./configure --with-php-config=$BASE_DIR/server/php/bin/php-config &&
    make && make install
    echo "zend_extension=${extension_dir}/xdebug.so" >> $BASE_DIR/server/php/etc/php.ini
    echo 'xdebug.remote_enable=1 ' >> $BASE_DIR/server/php/etc/php.ini &&  \
    echo 'xdebug.remote_autostart=1' >> $BASE_DIR/server/php/etc/php.ini &&   \
    echo 'xdebug.remote_connect_back=1' >> $BASE_DIR/server/php/etc/php.ini && \
    echo 'xdebug.remote_handler=dbgp' >> $BASE_DIR/server/php/etc/php.ini && \
    echo 'xdebug.remote_port=9000' >> $BASE_DIR/server/php/etc/php.ini && \
    echo 'xdebug.idekey=PHPSTORM' >> $BASE_DIR/server/php/etc/php.ini
    cd ..
fi
