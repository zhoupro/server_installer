#!/bin/bash
function pre_install(){
    mkdir -p $BASE_DIR/server/php
    source ./dep_env.sh
}

function post_install(){

    PHP_FPM_CONF="$BASE_DIR/server/php/etc/php-fpm.d/www.conf"
    cd ..
    cp ./php-${SERVER_VERSION}/php.ini-production $BASE_DIR/server/php/etc/php.ini
    #adjust php.ini
    sed -i 's/post_max_size = 8M/post_max_size = 64M/g' $BASE_DIR/server/php/etc/php.ini
    sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 64M/g' $BASE_DIR/server/php/etc/php.ini
    sed -i 's/;date.timezone =/date.timezone = PRC/g' $BASE_DIR/server/php/etc/php.ini
    sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/g' $BASE_DIR/server/php/etc/php.ini
    sed -i 's/max_execution_time = 30/max_execution_time = 300/g' $BASE_DIR/server/php/etc/php.ini
    #adjust php-fpm
    cp $BASE_DIR/server/php/etc/php-fpm.conf.default $BASE_DIR/server/php/etc/php-fpm.conf
    #self start
    cp $BASE_DIR/server/php/etc/php-fpm.d/www.conf.default $PHP_FPM_CONF 
    sed -i 's,listen = 127.0.0.1:9000,listen = 9000,g' $PHP_FPM_CONF 
    sed -i 's,user = nobody,user=www,g' $PHP_FPM_CONF 
    sed -i 's,group = nobody,group=www,g' $PHP_FPM_CONF 
    sed -i 's,^pm.min_spare_servers = 1,pm.min_spare_servers = 5,g'  $PHP_FPM_CONF 
    sed -i 's,^pm.max_spare_servers = 3,pm.max_spare_servers = 35,g'  $PHP_FPM_CONF 
    sed -i 's,^pm.max_children = 5,pm.max_children = 100,g' $PHP_FPM_CONF 
    sed -i 's,^pm.start_servers = 2,pm.start_servers = 20,g' $PHP_FPM_CONF 
    sed -i 's,;pid = run/php-fpm.pid,pid = run/php-fpm.pid,g'  $PHP_FPM_CONF 
    sed -i 's,listen = 127.0.0.1:9000,listen = [::]:9000,g'  $PHP_FPM_CONF 
    sed -i 's,;error_log = log/php-fpm.log,error_log = '$BASE_DIR'/server/php/var/log/php-fpm.log,g' $PHP_FPM_CONF 
    sed -i 's,;slowlog = log/$pool.log.slow,slowlog = '$BASE_DIR'/server/php/var/log/\$pool.log.slow,g' $PHP_FPM_CONF 
    install -v -m755 ./php-${SERVER_VERSION}/sapi/fpm/init.d.php-fpm  /etc/init.d/php-fpm
    /etc/init.d/php-fpm start
}

function install_server(){
    rm -rf php-${SERVER_VERSION}
    if [ ! -f php-${SERVER_VERSION}.tar.gz ];then
        wget http://mirrors.sohu.com/php/php-${SERVER_VERSION}.tar.gz  -O  php-${SERVER_VERSION}.tar.gz
    fi
    tar zxvf php-${SERVER_VERSION}.tar.gz
    cd php-${SERVER_VERSION}
    
    if [ "x$SERVER_DEBUG" == "x1" ]
    then
        CONFIG_DEBUG=" --with-debug   --disable-inline-optimization --enable-maintainer-zts  "
    else 
        CONFIG_DEBUG=""
    fi
    ./configure --prefix=$BASE_DIR/server/php \
    --with-config-file-path=$BASE_DIR/server/php/etc \
    $CONFIG_DEBUG \
    --with-mysqli=mysqlnd \
    --with-pdo-mysql=mysqlnd \
    --enable-fpm \
    --enable-static \
    --enable-sockets \
    --enable-zip \
    --enable-calendar \
    --enable-bcmath \
    --with-zlib \
    --with-iconv \
    --with-gd \
    --with-jpeg-dir \
    --with-xmlrpc \
    --enable-mbstring \
    --without-sqlite \
    --enable-ftp \
    --with-openssl \
    --enable-intl

    CPU_NUM=$(cat /proc/cpuinfo | grep processor | wc -l)
    if [ $CPU_NUM -gt 1 ];then
        make  -j$CPU_NUM
    else
        make 
    fi
    make install
}
function remove_server(){
    /etc/init.d/php-fpm stop
    rm -rf  $BASE_DIR/server/php
}
