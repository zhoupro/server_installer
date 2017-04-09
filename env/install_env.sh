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

if [ ! -f libpng-1.2.50.tar.gz ];then
    wget http://prdownloads.sourceforge.net/libpng/libpng-1.2.50.tar.gz
fi
rm -rf libpng-1.2.50
tar zxvf libpng-1.2.50.tar.gz
cd libpng-1.2.50
./configure --prefix=/usr/local/libpng.1.2.50
if [ $CPU_NUM -gt 1 ];then
    make CFLAGS=-fpic -j$CPU_NUM
else
    make CFLAGS=-fpic
fi
make install
cd ..

git clone git://github.com/libevent/libevent.git
cd libevent
git checkout release-1.4.14b-stable
./autogen.sh
./configure
make
make install
cd ..

if [ ! -f libmcrypt-2.5.8.tar.gz ];then
	wget   https://sourceforge.net/projects/mcrypt/files/Libmcrypt/2.5.8/libmcrypt-2.5.8.tar.gz/download -O libmcrypt-2.5.8.tar.gz
fi
rm -rf libmcrypt-2.5.8
tar zxvf libmcrypt-2.5.8.tar.gz
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


if [ ! -f jpegsrc.v6b.tar.gz ];then
	wget http://www.ijg.org/files/jpegsrc.v6b.tar.gz
fi
rm -rf jpeg-6b
tar zxvf jpegsrc.v6b.tar.gz
cd jpeg-6b
if [ -e /usr/share/libtool/config.guess ];then
cp -f /usr/share/libtool/config.guess .
elif [ -e /usr/share/libtool/config/config.guess ];then
cp -f /usr/share/libtool/config/config.guess .
fi
if [ -e /usr/share/libtool/config.sub ];then
cp -f /usr/share/libtool/config.sub .
elif [ -e /usr/share/libtool/config/config.sub ];then
cp -f /usr/share/libtool/config/config.sub .
fi
./configure --prefix=/usr/local/jpeg.6 --enable-shared --enable-static
mkdir -p /usr/local/jpeg.6/include
mkdir /usr/local/jpeg.6/lib
mkdir /usr/local/jpeg.6/bin
mkdir -p /usr/local/jpeg.6/man/man1
if [ $CPU_NUM -gt 1 ];then
    make -j$CPU_NUM
else
    make
fi
make install-lib
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


