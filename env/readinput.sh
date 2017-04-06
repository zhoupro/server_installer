#!/usr/bin/env bash

#参数说明函数
function helper(){
    echo "-h: help info";
    echo "-u: uninstall"
    echo "-s: silence install";
    echo "-i: interactive"
    echo "-c: rm download package"

    echo "-m: enable mysql,1:5.6.21"
    echo "-p: enable php,1:5.3.29 2:5.6.30 3:7.1.3"
    echo "-e: only php ext"
    echo "-n: enable nginx,1:1.4.4"
    echo "-d: debug mode,1:local mini，2:online mini，3:all"
    echo "-x: sphinx,install mysql first"

}

ifmysql=0
ifphp=0
ifnginx=0

if ( ! getopts "husic" opt); then
	echo "Usage: `basename $0` options (-hsmpndui) -h for help";
	exit 1;
fi
debug_choice=1
while getopts "m:p:n:d:e:hsusxic" opt;
do
     case $opt in
         h) helper;exit 1;;
         s)  silence=1;;
         m)
            mysql_choice=${OPTARG}
            ifmysql=1;;
         p)
            php_choice=${OPTARG};
            ifphp=1;


            ;;
         e)
            php_choice=${OPTARG};
            ifphp=0;
            ifext=1;
            ;;
         n)
             nginx_choice=${OPTARG}
             ifnginx=1;;
         d)
            debug_choice=${OPTARG}
            isdebug=1;;
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



####---- question selection ----begin####
if ((1$ifnginx==11)) ;then
    tmp=1
    if (( 1$silence==11 )) ;then
        tmp=$nginx_choice
    else
        read -p "Please select the nginx version of 1.4.4, input 1: " tmp
    fi

    if [ "$tmp" == "1" ];then
        nginx_version=1.4.4
    fi
    echo "nginx :  $nginx_version"
    web_dir=nginx-${nginx_version}
fi

if ((1$ifphp==11||1$ifext==11)) ;then
    tmp=1
    if (( 1$silence==11 )) ;then
        tmp=$php_choice
    else
        read -p "Please select the php version of 5.3.29/5.6.30/7.1.3, input 1 or 2 or 3 : " tmp
    fi
    if [ "$tmp" == "1" ];then
        php_version=5.3.29
    elif [ "$tmp" == "2" ];then
        php_version=5.6.30
    elif [ "$tmp" == "3" ];then
        php_version=7.1.3
    fi
    echo "php    : $php_version"
    php_dir=php-${php_version}
fi



if ((1$ifmysql==11)) ;then
    tmp=1
    if (( 1$silence==11 )) ;then
        tmp=$mysql_choice
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