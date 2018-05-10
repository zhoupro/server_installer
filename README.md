### 简介
安装各种常用的服务，如mysql, php, nginx, redis等

### 软件
* nginx 
* mysql
* php
* redis
* ftp 

### php

#### install with debug 
./install -s php:7.2.5 -b /home/demo/opt -d
#### install without debug 
./install -s php:7.2.5 -b /home/demo/opt 
#### uninstall
./install -s php:7.2.5 -b /home/demo/opt -u
#### version
* 7.2.*
* 7.1.*
* 7.0.*

### nginx

#### install with debug 
./install -s nginx:1.14.1 -b /home/demo/opt -d
#### install without debug 
./install -s nginx:1.14.1 -b /home/demo/opt 
#### uninstall
./install -s nginx:1.14.1 -b /home/demo/opt -u
#### version
* 1.14.*

### redis

#### install with debug 
./install -s redis:4.0.* -b /home/demo/opt -d
#### install without debug 
./install -s redis:4.0.* -b /home/demo/opt 
#### uninstall
./install -s redis:4.0.* -b /home/demo/opt -u
#### version
* 4.0.*
