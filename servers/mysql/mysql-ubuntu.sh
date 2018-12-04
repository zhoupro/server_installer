#!/bin/bash
function pre_install(){
    apt-get install -y libncurses5-dev libaio1 cmake
    ! cat /etc/passwd | grep mysql && \
    groupadd mysql && \
    useradd -r -g mysql -s /bin/false mysql
}


function post_install(){
    cd /usr/local/mysql
    chown -R mysql .
    chgrp -R mysql .
    script/mysql_install_db --user=mysql
    cp support-files/my-default.cnf /etc/my.cnf
    bin/mysqld_safe --user=mysql &
}

function install_server(){
    rm -rf mysql-${SERVER_VERSION}
    BIG_VERSION=`expr  "$SERVER_VERSION" : '\([0-9]*.[0-9]*\).[0-9]*'`
    if [ ! -f mysql-${SERVER_VERSION}.tar.gz ];then
        wget https://dev.mysql.com/get/Downloads/MySQL-${BIG_VERSION}/mysql-${SERVER_VERSION}.tar.gz
    fi
    tar xzvf mysql-${SERVER_VERSION}.tar.gz && \
    cd mysql-${SERVER_VERSION}
    mkdir bld && cd bld

    if [ "x$SERVER_DEBUG" == "x1" ]
    then
        cmake -DWITH_DEBUG=1  ..
    else 
        cmake  ..
    fi

    make && make install
}
function remove_server(){
    rm -rf /usr/local/mysql
}
