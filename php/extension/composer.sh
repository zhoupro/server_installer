#!/usr/bin/env bash

#install composer
/usr/local/bin/pxy wget "https://getcomposer.org/download/1.4.0/composer.phar" && mv composer.phar /usr/local/bin/composer
chmod 777 -R /usr/local/bin/composer

