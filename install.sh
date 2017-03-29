#!/bin/bash
###########
#环境搭建脚本
#author:prozhou
#email:zhoushengzheng@gmail.com
###########

#参数说明函数
function helper(){
    echo "-h: help info";
    echo "-s: silence install";
    echo "-m: enable mysql, not silence"
    echo "-p: enable php, not silence"
    echo "-n: enable nginx, not silence"
    echo "-d: debug mode"
    echo "-u: uninstall"
    echo "-x: sphinx,install mysql first"
    echo "-i: interactive"
    echo "-c: rm download package"
}

ifmysql=0
ifphp=0
ifnginx=0

if ( ! getopts "ish" opt); then
	echo "Usage: `basename $0` options (-hsmpndui) -h for help";
	exit $E_OPTERROR;
fi

while getopts "hsmpndusxc" opt;
do
     case $opt in
         h) helper;exit 1;;
         s)  silence=1;;
         m)  ifmysql=1;;
         p)  ifphp=1;;
         n)  ifnginx=1;;
         d)  isdebug=1;;
         x)
             if (( '1'$ifmysql!='11' )) ;
             then
                helper;
                exit 1
             fi
             issphinx=1;;
         u) isrm=1;;
         c) isclean=1;;
     esac
done


echo "Install beginning"
if (( 1$silence!=11 )) ;then
        soft=$(whiptail --title "Please select the install soft" --checklist \
        "soft selector" 15 60 4 \
        "php" "php-fpm" ON \
        "mysql" "mysql-server" OFF \
        "nginx" "nginx-server" ON  3>&1 1>&2 2>&3)

        exitstatus=$?
        if [ $exitstatus = 0 ]; then
            echo "The install soft are:" $soft
        else
            echo "You chose Cancel."
            exit 1
        fi



        if $(echo $soft|grep -wq "mysql") ;
        then
            ifmysql=1
        fi

        if $(echo $soft|grep -wq "php") ;
        then
            ifphp=1
        fi

        if $(echo $soft|grep -wq "nginx") ;
        then
            ifnginx=1
        fi
fi


if (( 1$isrm==11 )) ;then
    ifmysql=0
    ifphp=0
    ifnginx=0
fi

####---- Clean up the environment ----begin####
echo "will be uninstalled, wait ..."
source ./uninstall.sh
####---- Clean up the environment ----end####

install_log="$install_dir/website-info.log"


####---- question selection ----begin####
if ((1$ifnginx==11)) ;then
    tmp=1
    if (( 1$silence==11 )) ;then
        tmp="1"
    else
        read -p "Please select the nginx version of 1.4.4, input 1: " tmp
    fi

    if [ "$tmp" == "1" ];then
        nginx_version=1.4.4
    fi
    echo "nginx :  $nginx_version"
    web_dir=nginx-${nginx_version}
fi

if ((1$ifphp==11)) ;then
    tmp=1
    if (( 1$silence==11 )) ;then
        tmp="1"
    else
        read -p "Please select the php version of 5.3.29/5.4.23/5.5.7/5.6.30, input 1 or 2 or 3 or 4 : " tmp
    fi
    if [ "$tmp" == "1" ];then
        php_version=5.3.29
    elif [ "$tmp" == "2" ];then
        php_version=5.4.23
    elif [ "$tmp" == "3" ];then
        php_version=5.5.7
    elif [ "$tmp" == "4" ];then
        php_version=5.6.30
    fi


    echo "php    : $php_version"
    php_dir=php-${php_version}
fi


if ((1$ifmysql==11)) ;then
    tmp=1
    if (( 1$silence==11 )) ;then
        tmp="1"
    else
        read -p "Please select the mysql version of 5.6.21, input 1: " tmp
    fi

    if [ "$tmp" == "1" ];then
         mysql_version=5.6.21
    fi

    echo "mysql :  $mysql_version"
    mysql_dir=mysql-${mysql_version}
fi

if (( 1$silence==11 )) ;then
    isY="y"
else
    read -p "Enter the y or Y to continue:" isY
fi

if [ "${isY}" != "y" ] && [ "${isY}" != "Y" ];then
   exit 1
fi

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
    if ! cat /etc/rc.local | grep "/etc/init.d/nginx" > /dev/null;then
        echo "/etc/init.d/nginx start" >> /etc/rc.local
    fi
    /etc/init.d/php-fpm restart > /dev/null
    server_path="$server_path:"$install_dir"/server/nginx/sbin"
fi



if ((1$ifmysql==11)) ;then
    source ./mysql/install_${mysql_dir}.sh
    echo "---------- ${mysql_dir} ok ----------" >> tmp.log
    ####---- Start command is written to the rc.local ----begin####
    if ! cat /etc/rc.local | grep "/etc/init.d/mysqld" > /dev/null;then
        echo "/etc/init.d/mysqld start" >> /etc/rc.local
    fi

    if ((1$ifphp==11)) ;then
        ####---- mysql password initialization ----begin####
        echo "---------- rc init ok ----------" >> tmp.log
        $install_dir/server/php/bin/php -f ./res/init_mysql.php
        echo "---------- mysql init ok ----------" >> tmp.log
        ####---- mysql password initialization ----end####
    fi

    server_path="$server_path:"$install_dir'/server/mysql/bin'
fi


source ./php/install_sphinx.sh

if ((1$ifphp==11)) ;then
    source ./env/install_env.sh
    echo "---------- env ok ----------" >> tmp.log
    source ./php/install_nginx_php-${php_version}.sh
    echo "---------- ${php_dir} ok ----------" >> tmp.log
    source ./php/install_php_extension.sh
    echo "---------- php extension ok ----------" >> tmp.log
    if ! cat /etc/rc.local | grep "/etc/init.d/php-fpm" > /dev/null;then
        echo "/etc/init.d/php-fpm start" >> /etc/rc.local
    fi
    server_path="$server_path:"$install_dir'/server/php/sbin:'$install_dir'/server/php/bin'

fi



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
