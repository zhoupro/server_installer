#!/bin/bash
function pre_install(){
    apt-get install -y libncurses5-dev libaio1 cmake build-essential \
        gcc g++ git flex bison \
        mpi-default-dev libicu-dev python-dev libbz2-dev
    ! cat /etc/passwd | grep mysql && \
    groupadd mysql && \
    useradd -r -g mysql -s /bin/false mysql
}


function post_install(){
    cd /usr/local/mysql
    mkdir mysql-files
    chown mysql:mysql mysql-files
    chmod 750 mysql-files
    bin/mysqld --initialize-insecure --user=mysql
    bin/mysqld_safe --user=mysql &
}

function install_server(){
    BIG_VERSION=`expr  "$SERVER_VERSION" : '\([0-9]*.[0-9]*\).[0-9]*'`
    if [ ! -f mysql-${SERVER_VERSION}.tar.gz ];then
        wget https://dev.mysql.com/get/Downloads/MySQL-${BIG_VERSION}/mysql-${SERVER_VERSION}.tar.gz
    fi
    if [ ! -d mysql-${SERVER_VERSION} ];then
        tar xzvf mysql-${SERVER_VERSION}.tar.gz
    fi
    cd mysql-${SERVER_VERSION}
    if [ ! -d bld ]; then
        mkdir -p bld
        mkdir -p boost
    fi
    cd bld

    if [ "x$SERVER_DEBUG" == "x1" ]
    then
        cmake  \
            -DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
            -DWITH_MYISAM_STORAGE_ENGINE=1 \
            -DWITH_INNOBASE_STORAGE_ENGINE=1 \
            -DWITH_MEMORY_STORAGE_ENGINE=1 \
            -DWITH_READLINE=1 \
            -DWITH_PARTITION_STORAGE_ENGINE=1 \
            -DEXTRA_CHARSETS=all \
            -DDEFAULT_CHARSET=utf8 \
            -DDEFAULT_COLLATION=utf8_general_ci \
            -DENABLE_DOWNLOADS=1 \
            -DDOWNLOAD_BOOST=1 \
            -DDOWNLOAD_BOOST_TIMEOUT=6000 \
            -DWITH_BOOST=../boost \
            -DWITH_DEBUG=1 \
            ..
    else 
        cmake  \
            -DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
            -DWITH_MYISAM_STORAGE_ENGINE=1 \
            -DWITH_INNOBASE_STORAGE_ENGINE=1 \
            -DWITH_MEMORY_STORAGE_ENGINE=1 \
            -DWITH_READLINE=1 \
            -DWITH_PARTITION_STORAGE_ENGINE=1 \
            -DEXTRA_CHARSETS=all \
            -DDEFAULT_CHARSET=utf8 \
            -DDEFAULT_COLLATION=utf8_general_ci \
            -DENABLE_DOWNLOADS=1 \
            -DDOWNLOAD_BOOST=1 \
            -DDOWNLOAD_BOOST_TIMEOUT=6000 \
            -DWITH_BOOST=../boost \
            ..
    fi
    make   && \
    make install
}
function remove_server(){
    rm -rf /usr/local/mysql
}
