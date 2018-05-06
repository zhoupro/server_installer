#!/usr/bin/env bash

case $php_version in
     5.3.29)

        #sphinx
        if [ ! -f sphinx-2.0.8-release.tar.gz ];then
            wget http://sphinxsearch.com/files/sphinx-2.0.8-release.tar.gz
        fi

        tar zxvf sphinx-2.0.8-release.tar.gz
        cd sphinx-2.0.8-release
        ./configure --prefix=$install_dir/server/sphinx --with-mysql
        make && make install
        cd ..
        ;;
esac




