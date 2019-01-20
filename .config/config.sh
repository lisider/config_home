#!/bin/bash

CONFIG_BASE=~/.config

source ${CONFIG_BASE}/conf/base.conf

source ${CONFIG_BASE}/func/config1.sh


Main(){
	# 当前目录 为 /home/${USERNAME}
	echo cuerrnt directory is ${pwd}

	echo "source ~/.config/alias" >> ~/.bashrc

	cd ${CONFIG_BASE}

	# 脚本1
	Config1
}

Main $*
