#!/usr/bin/env bash

#参数说明函数
function helper(){
    echo "-h: help info";
    echo "-u: uninstall"
    echo "-s: server name,nginx:1.9.0"
    echo "-b: base dir"
    echo "-d: server debug"
}

if ( ! getopts "hus" opt); then
	echo "Usage: `basename $0` options (-hus) -h for help";
	exit 1;
fi

BASE_DIR="/data"

while getopts "s:b:duh" opt;
do
     case $opt in
         h) helper;exit 1
             ;;
         b)
            BASE_DIR=${OPTARG}
            ;;
         s)
            SERVER_INFO=${OPTARG}
            SERVER_NAME=$(echo $SERVER_INFO | awk -F ":" '{print $1}')
            SERVER_VERSION=$(echo $SERVER_INFO | awk -F ":" '{print $2}')
            ;;
         d)
             SERVER_DEBUG=1
            ;;
         u)
             SERVER_REMOVE=1
            ;;
     esac
done


