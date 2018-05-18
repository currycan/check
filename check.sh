#!/usr/bin/env bash

path=/var/log
[[ ! -d ${path} ]] && mkdir -p ${path}
log=${path}/shadowsocks-crond.log

ss_status=`ssrr status`
if [ $? -eq 0 ]; then
    pid=`echo $ss_status | sed 's/[^0-9]*//g'`
fi

if [ -z ${pid} ]; then
    echo "`date +"%Y-%m-%d %H:%M:%S"` ssrr is not running" >> ${log}
    echo "`date +"%Y-%m-%d %H:%M:%S"` Starting ssrr}" >> ${log}
    ssrr start &>/dev/null
    if [ $? -eq 0 ]; then
        echo "`date +"%Y-%m-%d %H:%M:%S"` ssrr start success" >> ${log}
    else
        echo "`date +"%Y-%m-%d %H:%M:%S"` ssrr start failed" >> ${log}
    fi
else
    echo "`date +"%Y-%m-%d %H:%M:%S"` ssrr is running with pid $pid" >> ${log}
fi
