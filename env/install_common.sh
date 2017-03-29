#!/usr/bin/env bash

if [ ! -f pcre-8.12.tar.gz ];then
	wget http://oss.aliyuncs.com/aliyunecs/onekey/pcre-8.12.tar.gz
fi
rm -rf pcre-8.12
tar zxvf pcre-8.12.tar.gz
cd pcre-8.12
./configure
if [ $CPU_NUM -gt 1 ];then
    make -j$CPU_NUM
else
    make
fi
make install
cd ..


if [ ! -f zlib-1.2.3.tar.gz ];then
	wget http://oss.aliyuncs.com/aliyunecs/onekey/zlib-1.2.3.tar.gz
fi
rm -rf zlib-1.2.3
tar zxvf zlib-1.2.3.tar.gz
cd zlib-1.2.3
./configure
if [ $CPU_NUM -gt 1 ];then
    make CFLAGS=-fpic -j$CPU_NUM
else
    make CFLAGS=-fpic
fi
make install
cd ..