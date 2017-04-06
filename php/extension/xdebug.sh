#!/usr/bin/env bash

case $php_version in
     5.3.29)
        git clone git://github.com/xdebug/xdebug.git
        cd xdebug/
        git checkout XDEBUG_2_2_1
        /data/server/php/bin/phpize
        ./configure --with-php-config=$install_dir/server/php/bin/php-config &&
        make && make install
        echo 'zend_extension='$install_dir/server/php'/lib/php/extensions/no-debug-non-zts-20090626/xdebug.so' >> /data/server/php/etc/php.ini
        echo 'xdebug.remote_enable=1 ' >> /data/server/php/etc/php.ini &&  \
        echo 'xdebug.remote_autostart=1' >> /data/server/php/etc/php.ini &&   \
        echo 'xdebug.remote_connect_back=1' >> /data/server/php/etc/php.ini && \
        echo 'xdebug.remote_handler=dbgp' >> /data/server/php/etc/php.ini && \
        echo 'xdebug.remote_port=9000' >> /data/server/php/etc/php.ini && \
        echo 'xdebug.idekey=PHPSTORM' >> /data/server/php/etc/php.ini
        cd ..
        ;;
     5.6.30)
        git clone git://github.com/xdebug/xdebug.git
        cd xdebug/
        git checkout XDEBUG_2_5_1
         /data/server/php/bin/phpize
        ./configure --with-php-config=$install_dir/server/php/bin/php-config &&
        make && make install
        echo 'zend_extension='$install_dir/server/php'/lib/php/extensions/no-debug-non-zts-20131226/xdebug.so' >> /data/server/php/etc/php.ini
        echo 'xdebug.remote_enable=1 ' >> /data/server/php/etc/php.ini &&  \
        echo 'xdebug.remote_autostart=1' >> /data/server/php/etc/php.ini &&   \
        echo 'xdebug.remote_connect_back=1' >> /data/server/php/etc/php.ini && \
        echo 'xdebug.remote_handler=dbgp' >> /data/server/php/etc/php.ini && \
        echo 'xdebug.remote_port=9000' >> /data/server/php/etc/php.ini && \
        echo 'xdebug.idekey=PHPSTORM' >> /data/server/php/etc/php.ini
        cd ..
        ;;
     7.1.3)
        git clone git://github.com/xdebug/xdebug.git
        cd xdebug/
        git checkout XDEBUG_2_5_1
         /data/server/php/bin/phpize
        ./configure --with-php-config=$install_dir/server/php/bin/php-config &&
        make && make install
        echo 'zend_extension='$install_dir/server/php'/lib/php/extensions/no-debug-non-zts-20160303/xdebug.so' >> /data/server/php/etc/php.ini
        echo 'xdebug.remote_enable=1 ' >> /data/server/php/etc/php.ini &&  \
        echo 'xdebug.remote_autostart=1' >> /data/server/php/etc/php.ini &&   \
        echo 'xdebug.remote_connect_back=1' >> /data/server/php/etc/php.ini && \
        echo 'xdebug.remote_handler=dbgp' >> /data/server/php/etc/php.ini && \
        echo 'xdebug.remote_port=9000' >> /data/server/php/etc/php.ini && \
        echo 'xdebug.idekey=PHPSTORM' >> /data/server/php/etc/php.ini
        cd ..
        ;;
esac

