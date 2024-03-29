### 简介
安装各种常用的服务，如mysql, php, nginx, redis等

### 软件
* nginx
* mysql
* php
* redis

### php

#### install with debug 
./install.sh -s php:7.2.5 -b /data -d
#### install without debug 
./install.sh -s php:7.2.5 -b /data 
#### uninstall
./install.sh -s php:7.2.5 -b /data -u
#### version
* 7.2
* 7.1
* 7.0

### nginx

#### install with debug 
./install.sh -s nginx:1.15.4 -b /data -d
#### install without debug 
./install.sh -s nginx:1.15.4 -b /data 
#### uninstall
./install.sh -s nginx:1.15.4 -b /data -u
#### version
* 1.15

### redis

#### install with debug 
```bash
./install.sh -s redis:4.0.* -b `pwd`/data -d
```
#### install without debug 
```bash
./install.sh -s redis:4.0.* -b `pwd`/data 
```
#### uninstall
```bash
./install.sh -s redis:4.0.* -b `pwd`/data -u
```
#### version
* 4.0

### go
#### install
./install.sh -s go:1.15.2

### mysql 
#### version
* 5.7
#### install with debug 
./install.sh -s mysql:5.7.24 -d
#### install without debug 
./install.sh -s mysql:5.7.24

### node
#### install
./install.sh -s node:12.19.0
