#!/bin/bash

#ATTENTION : source 文件是与路径相关的
source ${CONFIG_BASE}/conf/config1.conf
#ATTENTION : 下面的函数都是与路径无关的

Config1_test(){
    echo -e "\033[32m Do $FUNCNAME ... Start\033[0m"

    echo -e "\033[32m Do $FUNCNAME ... End\033[0m"
}

Config1(){
	Config1_test
}
