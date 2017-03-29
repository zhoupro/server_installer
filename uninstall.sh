#!/bin/bash

install_dir="/data"

mkdir -p $install_dir
echo ""
ifrpm=$(cat /proc/version | grep -E "redhat|centos")
ifdpkg=$(cat /proc/version | grep -Ei "ubuntu|debian")
ifcentos=$(cat /proc/version | grep centos)

#uninstall php
if ((1$ifphp==11)) ;then
    echo 'uninstall php'
    /etc/init.d/php-fpm stop &> /dev/null
    killall php-fpm &> /dev/null
    echo "--------> Clean up the installation environment"
    rm -rf /usr/local/freetype.2.1.10
    rm -rf /usr/local/libpng.1.2.50
    rm -rf /usr/local/freetype.2.1.10
    rm -rf /usr/local/libpng.1.2.50
    rm -rf /usr/local/jpeg.6

    echo "$install_dir/server/php               delete ok!"
    rm -rf "$install_dir/server/php"
    echo "$install_dir/server/php-*             delete ok!"
    rm -rf "$install_dir/server/php-*"
    echo ""
    echo "$install_dir/log/php                  delete ok!"
    rm -rf "$install_dir/log/php"
    echo "/etc/init.d/php-fpm        delete ok!"
    rm -rf /etc/init.d/php-fpm

    echo "/etc/rc.local                   clean ok!"
    if [ "$ifrpm" != "" ];then
        if [ -L /etc/rc.local ];then
            echo ""
        else
            \cp /etc/rc.local /etc/rc.local.bak
            rm -rf /etc/rc.local
            ln -s /etc/rc.d/rc.local /etc/rc.local
        fi

        sed -i "/\/etc\/init\.d\/php-fpm.*/d" /etc/rc.d/rc.local

    else
        sed -i "/\/etc\/init\.d\/php-fpm.*/d" /etc/rc.local
    fi

fi

#uninstall nginx
if ((1$ifnginx==11));then
    echo 'uninstall nginx'
    /etc/init.d/nginx stop &> /dev/null
    killall nginx &> /dev/null
    echo "$install_dir/server/nginx             delete ok!"
    rm -rf "$install_dir/server/nginx"
    echo "rm -rf $install_dir/server/nginx-*    delete ok!"
    rm -rf "$install_dir/server/nginx-*"
    echo "$install_dir/log/nginx                delete ok!"
    rm -rf "$install_dir/log/nginx"
    echo "--------> Clean up files"
    echo "/etc/rc.local                   clean ok!"
    if [ "$ifrpm" != "" ];then
        if [ -L /etc/rc.local ];then
            echo ""
        else
            \cp /etc/rc.local /etc/rc.local.bak
            rm -rf /etc/rc.local
            ln -s /etc/rc.d/rc.local /etc/rc.local
        fi
        sed -i "/\/etc\/init\.d\/nginx.*/d" /etc/rc.d/rc.local

    else
        sed -i "/\/etc\/init\.d\/nginx.*/d" /etc/rc.local
    fi
fi


#uninstall mysql



if ((1$ifmysql==11));then
    echo 'uninstall mysql'
    /etc/init.d/mysqld stop &> /dev/null
    killall mysqld &> /dev/null
    echo ""
    echo "--------> Delete directory"
    echo "$install_dir/server/mysql             delete ok!"
    rm -rf "$install_dir/server/mysql"
    echo "rm -rf $install_dir/server/mysql-*    delete ok!"
    rm -rf "$install_dir/server/mysql-*"
    echo "$install_dir/log/mysql                delete ok!"
    rm -rf "$install_dir/log/mysql"
    echo ""
    echo "--------> Delete file"
    echo "/etc/my.cnf                delete ok!"
    rm -f /etc/my.cnf
    echo "/etc/init.d/mysqld         delete ok!"
    rm -f /etc/init.d/mysqld

    echo "--------> Clean up files"
    echo "/etc/rc.local                   clean ok!"
    if [ "$ifrpm" != "" ];then
        if [ -L /etc/rc.local ];then
            echo ""
        else
            \cp /etc/rc.local /etc/rc.local.bak
            rm -rf /etc/rc.local
            ln -s /etc/rc.d/rc.local /etc/rc.local
        fi
        sed -i "/\/etc\/init\.d\/mysqld.*/d" /etc/rc.d/rc.local
    else
        sed -i "/\/etc\/init\.d\/mysqld.*/d" /etc/rc.local
    fi

    echo ""
    echo "/etc/profile                    clean ok!"
    sed -i '#export PATH=$PATH:'$install_dir'/server/mysql/bin.*#d' /etc/profile
    source /etc/profile

fi