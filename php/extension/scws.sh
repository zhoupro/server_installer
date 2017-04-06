#!/usr/bin/env bash


case $php_version in
     5.3.29)

        #scws
        if [ ! -f scws-1.2.2.tar.bz2 ];then
            wget http://www.xunsearch.com/scws/down/scws-1.2.2.tar.bz2
        fi

        rm -rf scws-1.2.2
        tar xvf scws-1.2.2.tar.bz2
        cd scws-1.2.2
        ./configure --prefix=$install_dir/server/scws --with-php-config=$install_dir/server/php/bin/php-config
        make && make install

        #scws ext
        cd phpext/
        $install_dir/server/php/bin/phpize
        ./configure --with-scws=$install_dir/server/scws/ --with-php-config=$install_dir/server/php/bin/php-config
        make && make install
        cd ../..
        cat >> $install_dir/server/php/etc/php.ini <<END
[scws]
extension = scws.so
scws.default.charset = utf8
scws.default.fpath = $install_dir/server/scws/
END
        if [ ! -f scws-dict-chs-utf8.tar.bz2 ];then
            wget http://www.xunsearch.com/scws/down/scws-dict-chs-utf8.tar.bz2
        fi

        tar xvjf scws-dict-chs-utf8.tar.bz2 -C  $install_dir/server/scws/etc/
        ;;
esac

