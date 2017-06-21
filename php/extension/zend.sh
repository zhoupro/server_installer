#!/usr/bin/env bash

extension_dir=`php-config --extension-dir`
mkdir -p extension_dir

case $php_version in
     5.3.29)
        if [ ! -f ZendGuardLoader-php-5.3-linux-glibc23-x86_64.tar.gz ];then
             wget http://downloads.zend.com/guard/5.5.0/ZendGuardLoader-php-5.3-linux-glibc23-x86_64.tar.gz
        fi
        tar zxvf ZendGuardLoader-php-5.3-linux-glibc23-x86_64.tar.gz
        mv ./ZendGuardLoader-php-5.3-linux-glibc23-x86_64/php-5.3.x/ZendGuardLoader.so ${extension_dir}/
        echo "zend_loader.enable=1" >> $install_dir/server/php/etc/php.ini
        echo "zend_loader.disable_licensing=0" >> $install_dir/server/php/etc/php.ini
        echo "zend_loader.obfuscation_level_support=3" >> $install_dir/server/php/etc/php.ini
        echo "zend_loader.license_path=" >> $install_dir/server/php/etc/php.ini
        echo "zend_extension=${extension_dir}/ZendGuardLoader.so" >> $install_dir/server/php/etc/php.ini
        ;;


     5.4.23)
        if [ ! -f ZendGuardLoader-70429-PHP-5.4-linux-glibc23-x86_64.tar.gz ];then
             wget http://downloads.zend.com/guard/6.0.0/ZendGuardLoader-70429-PHP-5.4-linux-glibc23-x86_64.tar.gz
        fi
        tar zxvf ZendGuardLoader-70429-PHP-5.4-linux-glibc23-x86_64.tar.gz
        mv ./ZendGuardLoader-70429-PHP-5.4-linux-glibc23-x86_64/php-5.4.x/ZendGuardLoader.so ${extension_dir}/
        echo "zend_loader.enable=1" >> $install_dir/server/php/etc/php.ini
        echo "zend_loader.disable_licensing=0" >> $install_dir/server/php/etc/php.ini
        echo "zend_loader.obfuscation_level_support=3" >> $install_dir/server/php/etc/php.ini
        echo "zend_loader.license_path=" >> $install_dir/server/php/etc/php.ini
        echo "zend_extension=${extension_dir}/ZendGuardLoader.so" >> $install_dir/server/php/etc/php.ini
        ;;
     5.6.30)
        mkdir -p $install_dir/server/php/lib/php/extensions/no-debug-non-zts-20131226
        if [ ! -f zend-loader-php5.6-linux-x86_64.tar.gz ];then
            wget http://downloads.zend.com/guard/7.0.0/zend-loader-php5.6-linux-x86_64.tar.gz
        fi
        tar zxvf zend-loader-php5.6-linux-x86_64.tar.gz
        mv ./zend-loader-php5.6-linux-x86_64/ZendGuardLoader.so ${extension_dir}/
        echo "zend_loader.enable=1" >> $install_dir/server/php/etc/php.ini
        echo "zend_loader.disable_licensing=0" >> $install_dir/server/php/etc/php.ini
        echo "zend_loader.obfuscation_level_support=3" >> $install_dir/server/php/etc/php.ini
        echo "zend_loader.license_path=" >> $install_dir/server/php/etc/php.ini
        echo "zend_extension=${extension_dir}//ZendGuardLoader.so" >> $install_dir/server/php/etc/php.ini
        ;;
esac
