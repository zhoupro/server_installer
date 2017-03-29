#!/bin/bash

rm -rf nginx-1.4.4
if [ ! -f nginx-1.4.4.tar.gz ];then
  wget http://oss.aliyuncs.com/aliyunecs/onekey/nginx/nginx-1.4.4.tar.gz
fi
tar zxvf nginx-1.4.4.tar.gz
cd nginx-1.4.4
./configure --user=www \
--group=www \
--prefix=$install_dir/server/nginx \
--with-http_stub_status_module \
--without-http-cache \
--with-http_ssl_module \
--with-http_gzip_static_module
CPU_NUM=$(cat /proc/cpuinfo | grep processor | wc -l)
if [ $CPU_NUM -gt 1 ];then
    make -j$CPU_NUM
else
    make
fi

make install
chmod 775 $install_dir/server/nginx/logs
chown -R www:www $install_dir/server/nginx/logs
chmod -R 775 $install_dir/www
chown -R www:www $install_dir/www
cd ..
cp -fR ./nginx/config-nginx/* $install_dir/server/nginx/conf/
sed -i 's/worker_processes  2/worker_processes  '"$CPU_NUM"'/' $install_dir/server/nginx/conf/nginx.conf
sed -i 's#/data#'"$install_dir"'#g' $install_dir/server/nginx/conf/vhost/*.conf.dist
sed -i 's#/installdir#'"$install_dir"'#' $install_dir/server/nginx/conf/nginx.conf
chmod 755 $install_dir/server/nginx/sbin/nginx
mv $install_dir/server/nginx/conf/nginx /etc/init.d/

sed -i 's#/installdir#'$install_dir'#' /etc/init.d/nginx
chmod +x /etc/init.d/nginx
/etc/init.d/nginx start
