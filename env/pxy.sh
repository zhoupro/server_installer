#!/usr/bin/env bash

export  http_proxy='http://172.17.0.1:8087'
export  https_proxy='http://172.17.0.1:8087'
export  HTTP_PROXY='http://172.17.0.1:8087'
export  HTTPS_PROXY='http://172.17.0.1:8087'
export  COMPOSER_CAFILE='/CA.crt'
start=$(date +%s)
$*
end=$(date +%s)
echo $(( end - start ))

unset http_proxy
unset https_proxy
unset HTTP_PROXY
unset HTTPS_PROXY
unset COMPOSER_CAFILE


