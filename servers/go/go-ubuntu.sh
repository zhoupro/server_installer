#!/bin/bash
function pre_install(){
    echo "pre install"
}

function post_install(){
    echo "post install"
}

function install_server(){
    rm -rf go-${SERVER_VERSION}
    if [ ! -f  go${SERVER_VERSION}.linux-amd64.tar.gz ];then
        wget https://dl.google.com/go/go${SERVER_VERSION}.linux-amd64.tar.gz
        tar -C /usr/local -xzf  go${SERVER_VERSION}.linux-amd64.tar.gz
    fi
    export PATH=$PATH:/usr/local/go/bin
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.env
}


function remove_server(){
    echo "removing go"
    rm -rf /usr/local/go
}
