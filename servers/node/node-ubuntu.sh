#!/bin/bash
function pre_install(){
    echo "pre install"
}

function post_install(){
    echo "post install"
}

function install_server(){
    if [ -f  /usr/local/lib/nodejs/node-${SERVER_VERSION}-linux-x64 ]
    then
        echo "nodejs had installed"
        return
    fi

    if [ ! -f  node-v${SERVER_VERSION}-linux-x64.tar.xz ];then
        mkdir -p /usr/local/lib/nodejs
        wget https://nodejs.org/dist/v${SERVER_VERSION}/node-v${SERVER_VERSION}-linux-x64.tar.xz
        tar -C /usr/local/lib/nodejs -xJf   node-v${SERVER_VERSION}-linux-x64.tar.xz
    fi
    export PATH=$PATH:/usr/local/lib/nodejs/node-v${SERVER_VERSION}-linux-x64/bin
    echo "export PATH=\$PATH:/usr/local/lib/nodejs/node-v${SERVER_VERSION}-linux-x64/bin" >> ~/.env
}
function remove_server(){
    echo "removing node"
    rm -rf /usr/local/lib/nodejs
}
