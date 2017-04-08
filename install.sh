#!/bin/bash
###########
#环境搭建脚本
#author:prozhou
#email:zhoushengzheng@gmail.com
###########

### question
echo "Question beginning"
source ./env/readinput.sh

### install pxy
cp ./env/CA.crt  /
cp ./env/pxy.sh  /usr/local/bin/pxy && chmod 777 -R /usr/local/bin/pxy


####---- Clean up the environment ----begin####
echo "will be uninstalled, wait ..."
source ./uninstall.sh
####---- Clean up the environment ----end####

install_log="$install_dir/website-info.log"

####---- install software ----begin####
rm -f tmp.log
echo "" >tmp.log
source ./env/install_set_ulimit.sh
source ./env/install_dir.sh
echo "---------- make dir ok ----------" >> tmp.log
source ./env/install_dep.sh
echo "---------- install dep ok ----------" >> tmp.log
source ./env/install_common.sh
echo "---------- install common ok ----------" >> tmp.log

server_path=''

if ((1$ifnginx==11)) ;then
    source ./nginx/install_nginx-${nginx_version}.sh
    echo "---------- ${web_dir} ok ----------" >> tmp.log
fi

if ((1$ifmysql==11)) ;then
    source ./mysql/install_${mysql_dir}.sh
    echo "---------- ${mysql_dir} ok ----------" >> tmp.log

    if ((1$ifphp==11)) ;then
        ####---- mysql password initialization ----begin####
        echo "---------- rc init ok ----------" >> tmp.log
        $install_dir/server/php/bin/php -f ./res/init_mysql.php
        echo "---------- mysql init ok ----------" >> tmp.log
        ####---- mysql password initialization ----end####
    fi
    server_path="$server_path:"$install_dir'/server/mysql/bin'
fi

if ((1$ifphp==11)) ;then
    source ./env/install_env.sh
    echo "---------- env ok ----------" >> tmp.log
    source ./php/install_nginx_php-${php_version}.sh
    echo "---------- ${php_dir} ok ----------" >> tmp.log
    server_path="$server_path:"$install_dir'/server/php/sbin:'$install_dir'/server/php/bin'
fi

source ext_index.sh
####---- Environment variable settings ----begin####
\cp /etc/profile /etc/profile.bak

echo 'export PATH=$PATH'$server_path >> /etc/profile
export PATH=${PATH}$server_path

if (( 1$isclean==11 )) ;then
    ls -d *-* | xargs rm -rf
fi

####---- log ----begin####
\cp tmp.log $install_log
cat $install_log
####---- log ----end####
