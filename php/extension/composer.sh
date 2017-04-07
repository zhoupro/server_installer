#!/usr/bin/env bash

#install composer
wget "https://getcomposer.org/download/1.4.0/composer.phar" && mv composer.phar /usr/local/bin/composer
chmod 777 -R /usr/local/bin/composer
/usr/local/bin/composer global config github-oauth.github.com 9b2e53a71cf0433889b99b3f28b13b109efd945f
