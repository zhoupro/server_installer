#!/bin/bash
###########
#环境搭建脚本
#author:prozhou
#email:zhoushengzheng@gmail.com
###########

### 指定安装的软件,版本, 安装目录, 安装模式 
source ./env/system_info.sh
source ./env/readinput.sh
#echo $CODENAME
#echo $SERVER_NAME, $SERVER_VERSION, $BASE_DIR, $SERVER_DEBUG, $SERVER_REMOVE 
INSTALL_LOG="$BASE_DIR/install-info.log"
####---- install software ----begin####
source ./env/install_set_ulimit.sh
source ./env/${CODENAME}_dep.sh
source ./env/install_common.sh


#include best install script
INSTALL_SCRIPT="/tmp/nosuchfile.sh"
INSTALL_SCRIPT_BASE_DIR="./servers/$SERVER_NAME"
if [ -f "${INSTALL_SCRIPT_BASE_DIR}/${SERVER_NAME}-${CODENAME}-${SERVER_VERSION}.sh"  ]
then
    INSTALL_SCRIPT="${INSTALL_SCRIPT_BASE_DIR}/${SERVER_NAME}-${CODENAME}-${SERVER_VERSION}.sh" 
elif [ -f "${INSTALL_SCRIPT_BASE_DIR}/${SERVER_NAME}-${CODENAME}.sh"  ]
then
    INSTALL_SCRIPT="${INSTALL_SCRIPT_BASE_DIR}/${SERVER_NAME}-${CODENAME}.sh" 
elif [ -f "${INSTALL_SCRIPT_BASE_DIR}/${SERVER_NAME}-${CODENAME}-comm-${SERVER_VERSION}.sh"  ]
then
    INSTALL_SCRIPT="${INSTALL_SCRIPT_BASE_DIR}/${SERVER_NAME}-${CODENAME}-comm-${SERVER_VERSION}.sh" 
elif [ -f "${INSTALL_SCRIPT_BASE_DIR}/${SERVER_NAME}-comm-${SERVER_VERSION}.sh"  ]
then
    INSTALL_SCRIPT="${INSTALL_SCRIPT_BASE_DIR}/${SERVER_NAME}-comm-${SERVER_VERSION}.sh" 
fi

if [ ! -f $INSTALL_SCRIPT ]
then
    echo "$INSTALL_SCRIPT is not exist"
    exit
fi
source $INSTALL_SCRIPT
cd "./servers/$SERVER_NAME"
if [ "x$SERVER_REMOVE" == "x1" ]
then
    remove_server
else
    pre_install 
    install_server
    post_install
fi
