#!/bin/bash
function pre_install(){
    mkdir -p  $BASE_DIR/server/redis-${SERVER_VERSION} 
}

function post_install(){
    ln -s $BASE_DIR/server/redis-${SERVER_VERSION} $BASE_DIR/server/redis
}

function install_server(){
    rm -rf redis-${SERVER_VERSION}
    if [ ! -f redis-${SERVER_VERSION}.tar.gz ];then
        wget https://github.com/antirez/redis/archive/${SERVER_VERSION}.tar.gz
    fi
    if [ "x$SERVER_DEBUG" == "x1" ]
    then
        CONFIG_DEBUG=" noopt "
    fi
     
    tar zxvf ${SERVER_VERSION}.tar.gz
    cd redis-${SERVER_VERSION}
    make $CONFIG_DEBUG 
    make   PREFIX=$BASE_DIR/server/redis-${SERVER_VERSION}  install
    cp *.conf    $BASE_DIR/server/redis-${SERVER_VERSION}/ 
}


function remove_server(){
    echo "removing redis"
    rm -rf  $BASE_DIR/server/${SERVER_NAME}
    rm -rf  redis-${SERVER_VERSION} 
    rm -rf  ${SERVER_VERSION}.tar.gz 
}
