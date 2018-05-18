#!/bin/sh
useradd www
sudo apt-get install -y  libxml2 libxml2-dev \
    libbz2-dev  libjpeg-dev libpng-dev \
    libxpm-dev libfreetype6-dev  libmcrypt-dev \
    libmysql++-dev  libxslt1-dev openssl libssl-dev  libcurl4-openssl-dev pkg-config
