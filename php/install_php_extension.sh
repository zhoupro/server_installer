#!/bin/bash

if [ `uname -m` == "x86_64" ];then
    machine=x86_64
else
    machine=i686
fi

#dev mode
if (( 1$isdebug==11 )) ;then

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

fi


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



#redis
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

if (( '1'$php_version='15.3.29' ));
then

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

fi



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



echo "zend_loader.enable=1" >> $install_dir/server/php/etc/php.ini
echo "zend_loader.disable_licensing=0" >> $install_dir/server/php/etc/php.ini
echo "zend_loader.obfuscation_level_support=3" >> $install_dir/server/php/etc/php.ini
echo "zend_loader.license_path=" >> $install_dir/server/php/etc/php.ini
#zend
if ls -l $install_dir/server/ |grep "5.3.29" > /dev/null;then
    mkdir -p $install_dir/server/php/lib/php/extensions/no-debug-non-zts-20090626/
    if [ ! -f ZendGuardLoader-php-5.3-linux-glibc23-x86_64.tar.gz ];then
        wget http://downloads.zend.com/guard/5.5.0/ZendGuardLoader-php-5.3-linux-glibc23-x86_64.tar.gz
    fi
    tar zxvf ZendGuardLoader-php-5.3-linux-glibc23-x86_64.tar.gz
    mv ./ZendGuardLoader-php-5.3-linux-glibc23-x86_64/php-5.3.x/ZendGuardLoader.so $install_dir/server/php/lib/php/extensions/no-debug-non-zts-20090626/
    echo "zend_extension=$install_dir/server/php/lib/php/extensions/no-debug-non-zts-20090626/ZendGuardLoader.so" >> $install_dir/server/php/etc/php.ini

elif ls -l $install_dir/server/ |grep "5.6.30" > /dev/null;then
    mkdir -p $install_dir/server/php/lib/php/extensions/no-debug-non-zts-20131226/
    if [ ! -f zend-loader-php5.6-linux-x86_64.tar.gz ];then
        wget http://downloads.zend.com/guard/7.0.0/zend-loader-php5.6-linux-x86_64.tar.gz
    fi
    tar zxvf zend-loader-php5.6-linux-x86_64.tar.gz
    mv ./zend-loader-php5.6-linux-x86_64/ZendGuardLoader.so $install_dir/server/php/lib/php/extensions/no-debug-non-zts-20131226/
    echo "zend_extension=$install_dir/server/php/lib/php/extensions/no-debug-non-zts-20131226/ZendGuardLoader.so" >> $install_dir/server/php/etc/php.ini
fi
