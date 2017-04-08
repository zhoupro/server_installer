## php依赖库安装
* libiconv 提供了一个iconv()的函数
* zlib    提供.gz文件支持
* freetype　图片支持
* libevent　高性能网络库
* pcre　　正则表达
* libxml2 —包含库和实用工具用于解析XML文件
* libmcrypt —加密算法扩展库(支持DES, 3DES, RIJNDAEL, Twofish, IDEA, GOST, CAST-256, ARCFOUR, SERPENT, SAFER+等算法)


## 系统安装
* 此安装包可在阿里云所有 linux 系统上部署安装,此安装包包含的软件及版本为:
nginx: 1.4.4
mysql:5.6.21
php:5.3.29、5.6.30
php 扩展:apc,memcache redis scws sphinx xdebug xhprof zend

* 执行一键安装包(./install.sh),会自动清理之前一键安装包安装过的环境。
如果您已经安装过一键安装包,再次执行安装,如若有重要数据,请自行备份/data 目录。

* 安装完成时检查是否安装成功
输入命令 :netstat -tunpl
我们可以看到正在运行状态的服务及端口:9000 端口是 php 进程服务,3306 端口是 mysql
服务,80 端口是 nginx 服务,21 端口是 ftp 服务。

* 修改虚拟主机
```bash
cd /data/server/nginx/conf/vhost
cp ghs.net.conf.dist ghs.net.conf
修改zendload内容
/etc/init.d/nginx restart

```

* 修改mysql密码

````bash
mysqladmin -uroot -p oldpwd password newpwd
````

* 环境目录及相关操作命令
>* 网站目录:/data/www
>* 服务器软件目录:/data/server
>* Mysql 目录 /data/server/mysql
>* Php 目录/data/server/php
>* nginx 目录/data/server/nginx

* 服务器操作命令汇总
>* nginx:
    /etc/init.d/nginx start/stop/restart/reload)
>* mysql:
　　/etc/init.d/mysqld start/stop/restart/...
>* php-fpm:
  /etc/init.d/php-fpm start/stop/restart/...
>* ftp:
   /etc/init.d/vsftpd start/stop/restart/...
   
## 参考链接
> [memcached名称解释](https://blog.linuxeye.com/345.html )
> [Zend Guard Loader](https://teddysun.com/417.html)

