#!/usr/bin/env bash
#正式数据库配置
sq_host='rds637zp6c38m5952l72.mysql.rds.aliyuncs.com'
sq_user='huanqiughs_2016w'
sq_pass='ghs2016)_+2o16'
sq_db='ecstore'

#sphinx安装
if (( 1$issphinx==11 )) ;then
    #sphinx
    if [ ! -f sphinx-2.0.8-release.tar.gz ];then
        wget http://sphinxsearch.com/files/sphinx-2.0.8-release.tar.gz
    fi

    tar zxvf sphinx-2.0.8-release.tar.gz
    cd sphinx-2.0.8-release
    ./configure --prefix=$install_dir/server/sphinx --with-mysql=$install_dir/server/mysql/
    make && make install
    cd ..
fi

#判断是否安装过ecstore
ecstore_sphinx=$install_dir/www/wwwroot/app/search/config/sphinx.conf
conf_sphinx=$install_dir/server/sphinx/etc/sphinx.conf

#sphinx
if [ ! -f  $conf_sphinx ] && [ -f $ecstore_sphinx ];
then
    echo "复制配置文件"
    \cp  $ecstore_sphinx  $conf_sphinx
    #数据库链接
    sed -i "s/sql_host		= localhost/sql_host		= $sq_host/g" $conf_sphinx
    sed -i "s/sql_user		= root/sql_user		= $sq_user/g" $conf_sphinx
    sed -i "s/sql_pass		=/sql_pass		= $sq_pass/g" $conf_sphinx
    sed -i "s/sql_db			= ecstore13/sql_db			= $sq_db/g" $conf_sphinx

    mkdir -p $install_dir/server/sphinx/var
    chmod 777 -R $install_dir/server/sphinx/var
    sed -i "s#/usr/local/var#$install_dir/server/sphinx/var#g" $conf_sphinx

    #定时生成索引脚本
    \cp  $install_dir/www/wwwroot/app/search/config/*.sh  $install_dir/sh/
    sed -i "s#/usr/local/webserver/sphinx#$install_dir/server/sphinx#g" $install_dir/sh/*_index.sh
    sed -i "s#/data/www/ecstore13#$install_dir/server/sphinx#g" $install_dir/sh/*_index.sh
    sed -i "s#/usr/local/var/log#$install_dir/server/sphinx/var/log#g" $install_dir/sh/*_index.sh
    sed -i "s#app/search/config/#etc/#g" $install_dir/sh/*_index.sh

    #添加cron
cat > /etc/cron.d/cron_sphinx <<END
#根据设置定时计划的合并频率时间修改sphinx.conf中的 where条件后面的时候 last_modify>unix_timestamp()-86400( 1天)
30 2 * * * $install_dir/sh/build_delta_index.sh > /dev/null 2>&1
* * * * *  $install_dir/sh/build_main_index.sh > /dev/null 2>&1
END

fi
