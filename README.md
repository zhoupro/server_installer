## 系统安装

###简介
此安装包使用于centos系列,执行一键安装包(./install.sh),
会自动清理之前一键安装包安装过的环境。如果您已经安装过一键安装包,
再次执行安装,如若有重要数据,请自行备份/data 目录。输入命令 :netstat -tunpl
我们可以看到正在运行状态的服务及端口:9000 端口是 php进程服务,3306 端口是 mysql
服务,80 端口是 nginx 服务,21 端口是 ftp 服务。


### 软件
* nginx: 1.4, 1.12
* mysql:5.6.21
* php:5.3, 5.4, 5.5, 5.6, 7.0, 7.1
* php 扩展:apc,memcache redis scws sphinx xdebug xhprof zend


### 配置nginx主机
```bash
cd /data/server/nginx/conf/vhost
cp default.conf.dist default.conf
修改zendload内容
/etc/init.d/nginx restart

```

### 修改mysql密码

````bash
mysqladmin -uroot -p oldpwd password newpwd
````

### 环境目录及相关操作命令
>* 网站目录:/data/www
>* 服务器软件目录:/data/server
>* Mysql 目录 /data/server/mysql
>* Php 目录/data/server/php
>* nginx 目录/data/server/nginx

### 服务器操作命令汇总
>* nginx:
    /etc/init.d/nginx start/stop/restart/reload)
>* mysql:
　　/etc/init.d/mysqld start/stop/restart/...
>* php-fpm:
  /etc/init.d/php-fpm start/stop/restart/...
>* ftp:
   /etc/init.d/vsftpd start/stop/restart/...
   
### 参考链接
> [Zend Guard Loader](https://teddysun.com/417.html)

