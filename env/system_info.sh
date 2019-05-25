#!/bin/bash
IFUBUNTU=$(cat /etc/issue | grep -i ubuntu)
IFCENTOS=$(cat /etc/issue | grep -i centos)

if [ "$(uname)" == "Darwin" ]; then
    CODENAME="mac"
    RELEASE=$(sw_vers | grep ProductVersion | awk  '{print $2}')
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    CODENAME=$(cat /etc/os-release | grep ^ID= | awk -F '=' '{print $2}' |sed -e 's/"//g')
    RELEASE=$(cat /etc/os-release | grep ^VERSION_ID= | awk -F '=' '{print $2}' |sed -e 's/"//g')
fi

