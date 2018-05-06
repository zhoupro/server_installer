#!/bin/bash
IFUBUNTU=$(cat /etc/issue | grep -i ubuntu)
IFCENTOS=$(cat /etc/issue | grep -i centos)

    
if [ "x$IFCENTOS" == "x1" ]
then
    yum install -y redhat-lsb
fi

#操作系统
CODENAME=$(cat /etc/lsb-release 2>/dev/null|awk -F "=" ' $1 == "DISTRIB_ID" {print $2}'|tr '[A-Z]' '[a-z]')
#数字号
RELEASE=$(cat /etc/lsb-release 2>/dev/null|awk -F "=" ' $1 == "DISTRIB_RELEASE" {print $2}')

