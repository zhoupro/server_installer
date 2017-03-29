#!/bin/bash

ifubuntu=$(cat /etc/issue | grep -i ubuntu)

mkdir -p $install_dir
mkdir -p $install_dir/server
mkdir -p $install_dir/log

if ((1$ifmysql==11)) ;then
    mkdir -p $install_dir/server/${mysql_dir}
    mkdir -p $install_dir/log/mysql
    ln -s $install_dir/server/${mysql_dir} $install_dir/server/mysql
fi

if ((1$ifphp==11)) ;then
    mkdir -p $install_dir/server/${php_dir}
    ln -s $install_dir/server/${php_dir} $install_dir/server/php
    mkdir -p $install_dir/log/php

fi

if ((1$ifnginx==11)) ;then
    useradd -s /bin/nologin www
    groupadd www
    if [ "$ifubuntu" != "" ];then
        useradd -g www -M -d /opt/www -s /usr/sbin/nologin www &> /dev/null
    else
        useradd -g www -M -d /opt/www -s /sbin/nologin www &> /dev/null

    fi
    mkdir -p $install_dir/server/${web_dir}

    mkdir -p $install_dir/www/wwwroot
    mkdir -p $install_dir/log/nginx
    mkdir -p $install_dir/log/nginx/access
    ln -s $install_dir/server/${web_dir} $install_dir/server/nginx
fi

chown -R www:www $install_dir/log