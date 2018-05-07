#!/bin/bash
function pre_install(){
    useradd -s /bin/nologin www
    groupadd www
    useradd -g www -M -d /opt/www -s /sbin/nologin www &> /dev/null
    mkdir -p $BASE_DIR/server/nginx/conf
    mkdir -p $BASE_DIR/www/wwwroot
    mkdir -p $BASE_DIR/log/nginx
    mkdir -p $BASE_DIR/log/nginx/access
    ln -s $BASE_DIR/server/nginx $BASE_DIR/server/nginx
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
        rm -rf  nginx-1.12.1
    fi
    /etc/init.d/nginx start
}

function install_server(){
    rm -rf nginx-1.12.1
    if [ ! -f nginx-1.12.1.tar.gz ];then
        wget http://nginx.org/download/nginx-1.12.1.tar.gz
    fi
    if [ "x$SERVER_DEBUG" == "x1" ]
    then
        CONFIG_DEBUG="--with-debug"
    fi
     
    tar zxvf nginx-1.12.1.tar.gz
    cd nginx-1.12.1
    ./configure --user=www \
        $CONFIG_DEBUG \
    --group=www \
    --prefix=$BASE_DIR/server/nginx \
    --with-http_stub_status_module \
    --without-http-cache \
    --with-http_ssl_module \
    --with-http_gzip_static_module
    CPU_NUM=$(cat /proc/cpuinfo | grep processor | wc -l)
    if [ $CPU_NUM -gt 1 ];then
        make -j$CPU_NUM
    else
        make
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
}
