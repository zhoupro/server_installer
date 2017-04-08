#!/usr/bin/env bash

if [ ! -f pcre-8.12.tar.gz ];then
	wget https://ftp.pcre.org/pub/pcre/pcre-8.12.tar.gz
fi
rm -rf pcre-8.12
tar zxvf pcre-8.12.tar.gz
cd pcre-8.12
./configure
make
make install
cd ..


if [ ! -f zlib-1.2.11.tar.xz ];then
  wget	http://zlib.net/zlib-1.2.11.tar.xz
fi
rm -rf zlib-1.2.11
tar Jxvf zlib-1.2.11.tar.xz
cd zlib-1.2.11
./configure
make CFLAGS=-fpic
make install
cd ..