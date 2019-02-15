#########################################################################
# File Name: vectors.sh
# Author: Sues
# mail: sumory.kaka@foxmail.com
# Created Time: Sat 21 Apr 2018 09:05:29 PM PDT
# Version : 1.0
#########################################################################
#!/bin/bash

Main(){

    USERNAME=$0
    echo username is ${USERNAME}

    apt-get install expect -y

	# 新建用户
    useradd ${USERNAME} -s /bin/bash -G sudo

	# 更改密码
PASSWD=123456
expect<<EOF
spawn passwd ${USERNAME}
expect "Enter new UNIX password:"
send "${PASSWD}\r"
expect "Retype new UNIX password:"
send "${PASSWD}\r"
expect eof;
EOF

    apt-get install git -y
	# 下载 工程 作为 家目录
    git clone https://github.com/lisider/config_home.git /home/${USERNAME}

	# 用模板配置家目录

    cp /etc/skel/.profile  /home/${USERNAME}/
    cp /etc/skel/.bashrc  /home/${USERNAME}/
    cp /etc/skel/.bash_logout  /home/${USERNAME}/

	# 更改家目录的权限
    chown ${USERNAME}:${USERNAME} /home/${USERNAME} -R

	# 配置免密码
    sed -i "\$a ${USERNAME} ALL=(ALL:ALL) NOPASSWD:ALL" /etc/sudoers

	# 以 ${USERNAME}  在 /home/${USERNAME} 执行 config.sh脚本
    cd /home/${USERNAME}
    #chmod a+x /home/${USERNAME}/.config/config.sh
    su - ${USERNAME} -c /home/${USERNAME}/.config/config.sh

}

Main $*
