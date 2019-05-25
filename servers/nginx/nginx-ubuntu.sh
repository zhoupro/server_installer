#!/bin/bash
function pre_install(){
    source  servers/nginx/install_common.sh
    apt-get install -y libssl-dev
    useradd -s /bin/nologin www
    groupadd www
    useradd -g www -M -d /opt/www -s /sbin/nologin www &> /dev/null
    mkdir -p $BASE_DIR/server/nginx/conf
    mkdir -p $BASE_DIR/www/wwwroot
    mkdir -p $BASE_DIR/log/nginx
    mkdir -p $BASE_DIR/log/nginx/access
    ln -s $BASE_DIR/server/nginx-${SERVER_VERSION} $BASE_DIR/server/nginx
}

function post_install(){
    chmod 775 $BASE_DIR/server/nginx/logs
    chown -R www:www $BASE_DIR/server/nginx/logs
    chmod -R 775 $BASE_DIR/www
    chown -R www:www $BASE_DIR/www
    cd ..
    cp -fR ./config-nginx/* $BASE_DIR/server/nginx/conf/
    sed -i 's/worker_processes  2/worker_processes  '"$CPU_NUM"'/' $BASE_DIR/server/nginx/conf/nginx.conf
    sed -i 's#/data#'"$BASE_DIR"'#g' $BASE_DIR/server/nginx/conf/vhost/*.conf.dist
    sed -i 's#/installdir#'"$BASE_DIR"'#' $BASE_DIR/server/nginx/conf/nginx.conf
    chmod 755 $BASE_DIR/server/nginx/sbin/nginx
    mv $BASE_DIR/server/nginx/conf/nginx /etc/init.d/
    sed -i 's#/installdir#'$BASE_DIR'#' /etc/init.d/nginx
    chmod +x /etc/init.d/nginx
    if [ "x$SERVER_DEBUG" != "x1" ]
    then
        rm -rf  nginx-${SERVER_VERSION}
    fi
    /etc/init.d/nginx start
}

function install_server(){
    rm -rf nginx-${SERVER_VERSION}
    if [ ! -f release-${SERVER_VERSION}.tar.gz ];then
        wget https://github.com/nginx/nginx/archive/release-${SERVER_VERSION}.tar.gz
    fi
    tar zxvf release-${SERVER_VERSION}.tar.gz
    cd nginx-release-${SERVER_VERSION}

    if [ "x$SERVER_DEBUG" == "x1" ]
        ./auto/configure  \
        --with-cc-opt='-ggdb3 -O0 -Wno-error' \
        --user=www --group=www \
        --prefix=$BASE_DIR/server/nginx \
        --with-http_stub_status_module \
        --without-http-cache \
        --with-http_gzip_static_module \
        --with-debug  
        CPU_NUM=$(cat /proc/cpuinfo | grep processor | wc -l)
        if [ $CPU_NUM -gt 1 ];then
            make -j$CPU_NUM CFLAGS='ggdb3 -O0 -Wno-error'

        else
            make CFLAGS='ggdb3 -O0 -Wno-error'
        fi
    then
        ./auto/configure  \
        --user=www \
        --group=www \
        --prefix=$BASE_DIR/server/nginx \
        --with-http_stub_status_module \
        --without-http-cache \
        --with-http_gzip_static_module
        CPU_NUM=$(cat /proc/cpuinfo | grep processor | wc -l)
        if [ $CPU_NUM -gt 1 ];then
            make -j$CPU_NUM
        else
            make
        fi
    fi
    
    make install
}


function remove_server(){
    echo "removing nginx"
    /etc/init.d/nginx stop
    rm -rf  $BASE_DIR/server/${SERVER_NAME}
    rm -rf  $BASE_DIR/www/wwwroot
    rm -rf  $BASE_DIR/log/nginx
    rm -rf  $BASE_DIR/log/nginx/access
    rm -rf  nginx-release-${SERVER_VERSION}
    rm -rf  nginx-release-${SERVER_VERSION}.tar.gz
}
