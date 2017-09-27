#!/bin/sh
CPU_NUM=$(cat /proc/cpuinfo | grep processor | wc -l)
if [ ! -f libiconv-1.15.tar.gz ];then
	wget https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.15.tar.gz
fi
rm -rf libiconv-1.15
tar zxvf libiconv-1.15.tar.gz
cd libiconv-1.15
./configure --prefix=/usr/local
if [ $CPU_NUM -gt 1 ];then
    make -j$CPU_NUM
else
    make
fi
make install
cd ..


if [ ! -f freetype-2.1.10.tar.gz ];then
	wget http://gnu.mirrors.pair.com/savannah/savannah/freetype/freetype-old/freetype-2.1.10.tar.gz

fi
rm -rf freetype-2.1.10
tar zxvf freetype-2.1.10.tar.gz
cd freetype-2.1.10
./configure --prefix=/usr/local/freetype.2.1.10
if [ $CPU_NUM -gt 1 ];then
    make -j$CPU_NUM
else
    make
fi
make install
cd ..

# centos源不能安装libmcrypt-devel，由于版权的原因没有自带mcrypt的包
if [ ! -f libmcrypt-2.5.8.tar.gz ];then
	wget   https://osdn.net/projects/mcrypt/downloads/67082/libmcrypt-2.5.8.1.tar.xz/ -O libmcrypt-2.5.8.tar.xz
fi
rm -rf libmcrypt-2.5.8
tar xJvf libmcrypt-2.5.8.tar.xz
cd libmcrypt-2.5.8
./configure --disable-posix-threads
make
make install
/sbin/ldconfig
cd libltdl/
./configure --enable-ltdl-install
make
make install
cd ../..


git clone git://github.com/libevent/libevent.git
cd libevent
git checkout release-1.4.14b-stable
./autogen.sh
./configure
make
make install
cd ..



#load /usr/local/lib .so
touch /etc/ld.so.conf.d/usrlib.conf
echo "/usr/local/lib" > /etc/ld.so.conf.d/usrlib.conf
/sbin/ldconfig

#create account.log
cat > account.log << END
##########################################################################
# 
# thank you for using aliyun virtual machine
# 
##########################################################################

MySQL:
account:root
password:mysql_password
END


