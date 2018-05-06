#!/usr/bin/env bash

if   [ ! -f /usr/local/include/pcre.h ];then
	wget https://ftp.pcre.org/pub/pcre/pcre-8.12.tar.gz
    rm -rf pcre-8.12
    tar zxvf pcre-8.12.tar.gz
    cd pcre-8.12
    ./configure
    make
    make install
    cd ..
    rm -rf pcre-8.12*
fi


if   [ ! -f /usr/local/include/zlib.h ];then
    wget	https://github.com/madler/zlib/archive/v1.2.11.tar.gz -O zlib-1.2.11.tar.gz
    rm -rf zlib-1.2.11
    tar xxvf zlib-1.2.11.tar.gz
    cd zlib-1.2.11
    ./configure
    make CFLAGS=-fpic
    make install
    cd ..
    rm -rf zlib-1.2.11*
fi
