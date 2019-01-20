#########################################################################
# File Name: ../func/optimization.sh
# Author: Sues
# mail: sumory.kaka@foxmail.com
# Created Time: Wed 24 Jan 2018 11:55:53 AM CST
# Version : 1.0
#########################################################################
#!/bin/bash


#ATTENTION : source 文件是与路径相关的
source ${CONFIG_BASE}/conf/base_conf.conf
#ATTENTION : 下面的函数都是与路径无关的

Timing(){
    echo -e "\033[32m Do $FUNCNAME ... Start\033[0m"
	sudo apt-get install ntpdate -y
    echo ${PASSWD} | sudo ntpdate ${CHINANATIONALTIMESERVICECENTER}
    echo -e "\033[32m Do $FUNCNAME ... End\033[0m"
}


Samba(){
    echo -e "\033[32m Do $FUNCNAME ... Start\033[0m"
     sudo apt-get install samba -y


expect<<EOF
spawn sudo pdbedit -a -u ${USER}
expect "new password:"
send "${PASSWD}\r"
expect "retype new password:"
send "${PASSWD}\r"
expect eof;
EOF

     sudo chmod 666 /etc/samba/smb.conf

sudo cat >> /etc/samba/smb.conf <<ipipopopopqru23
[homes]
     comment = Home Directories
     browseable = no
     writeable = yes
     create mode = 0664
     directory mode = 0775
ipipopopopqru23

     sudo chmod 644 /etc/samba/smb.conf

     sudo /etc/init.d/smbd restart
    echo -e "\033[32m Do $FUNCNAME ... End\033[0m"
}


Vsftpd(){
    echo -e "\033[32m Do $FUNCNAME ... Start\033[0m"
     sudo apt-get install vsftpd -y
    echo -e "\033[32m Do $FUNCNAME ... End\033[0m"
}

Nfs(){
    echo -e "\033[32m Do $FUNCNAME ... Start\033[0m"
    sudo  apt-get install nfs-kernel-server -y
    echo -e "\033[32m Do $FUNCNAME ... End\033[0m"
}

AutoNfs(){
    echo -e "\033[32m Do $FUNCNAME ... Start\033[0m"
    sudo apt-get install autofs -y

    sudo chmod 666 /etc/auto.master
    sudo echo "/mnt/nfs /etc/auto.nfs" >> /etc/auto.master
    sudo chmod 644 /etc/auto.master


	ipaddr=ifconfig ens33 | grep "inet addr" | awk '{ print $2 }' | awk -F: '{print $2}'
    sudo touch /etc/auto.nfs
    sudo chmod 666 /etc/auto.nfs
	sudo echo "${USER} -rw,bg,soft,rsize=32768,wsize=32768 ${ipaddr}:/home/${USER}" > /etc/auto.nfs
    sudo chmod 644 /etc/auto.nfs


    sudo /etc/init.d/autofs restart
    echo -e "\033[32m Do $FUNCNAME ... End\033[0m"
}

Zsh(){
	 echo -e "\033[32m Do $FUNCNAME ... Start\033[0m"
     sudo apt-get install zsh -y

     cd ${HOME}
     git clone https://github.com/powerline/fonts.git --depth=1
     cd fonts;./install.sh
     sudo fc-cache ${HOME}/.local -fv

     cd ${HOME}
     sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"


     #修改主题
     sed '10 s/robbyrussell/agnoster/' ${HOME}/.zshrc -i

     echo -e "\033[32m you need to modify Graphic interface shell through Edit -> Profile Preferences -> Gernal \033[0m"
     echo -e "\033[32m you can modify the last field of /etc/passwd to /usr/bin/zsh \033[0m"
	 echo -e "\033[32m Do $FUNCNAME ... End\033[0m"

     # 增加 Zsh 的 alias
     echo "source ~/.config/alias" >> ~/.zshrc

}


Tmux(){
    echo -e "\033[32m Do $FUNCNAME ... Start\033[0m"
    sudo apt-get install tmux -y
    cd ${HOME}
    git clone https://github.com/gpakosz/.tmux.git
    ln -s -f .tmux/.tmux.conf
    cp .tmux/.tmux.conf.local .
    echo -e "\033[32m Do $FUNCNAME ... End\033[0m"
}


Ssh(){

    echo -e "\033[32m Do $FUNCNAME ... Start\033[0m"

    sudo apt-get install openssh-server -y

    echo -e "\033[32m Do $FUNCNAME ... End\033[0m"

}

Trash(){
    echo -e "\033[32m Do $FUNCNAME ... Start\033[0m"

    sudo apt-get install trash-cli -y

    echo -e "\033[32m Do $FUNCNAME ... End\033[0m"
}

Bd(){

    echo -e "\033[32m Do $FUNCNAME ... Start\033[0m"

    sudo wget --no-check-certificate -O /usr/bin/bd https://raw.github.com/vigneshwaranr/bd/master/bd
    sudo chmod +rx /usr/bin/bd
    echo 'alias bd=". bd -si"' >> ${CONFIG_BASE}/alias
    source ${CONFIG_BASE}/alias

    echo -e "\033[32m Do $FUNCNAME ... End\033[0m"

}

Cheat(){
    echo -e "\033[32m Do $FUNCNAME ... Start\033[0m"

    pip install docopt pygments
    git clone https://github.com/chrisallenlane/cheat.git
    cd cheat
    sudo python setup.py install
    wget https://github.com/chrisallenlane/cheat/raw/master/cheat/autocompletion/cheat.bash 
    sudo mv cheat.bash /etc/bash_completion.d/
    echo 'export CHEATCOLOR=true' >> ${CONFIG_BASE}/alias
    echo 'alias q="cheat"' >> ${CONFIG_BASE}/alias
    source ${CONFIG_BASE}/alias

    echo -e "\033[32m Do $FUNCNAME ... End\033[0m"
}

MkdirDirectory(){
    echo -e "\033[32m Do $FUNCNAME ... Start\033[0m"
    cd /home/${USER}
    mkdir work
    mkdir tmp
    echo -e "\033[32m Do $FUNCNAME ... End\033[0m"
}

Fish(){
    echo -e "\033[32m Do $FUNCNAME ... Start\033[0m"
    sudo apt-get install fish -y
    echo -e "\033[32m Do $FUNCNAME ... End\033[0m"
}

TheFuck(){
    echo -e "\033[32m Do $FUNCNAME ... Start\033[0m"

    sudo apt install python3-dev python3-pip -y
    sudo pip3 install thefuck
    echo -e "\033[32m Do $FUNCNAME ... End\033[0m"
}

Ici(){
    echo -e "\033[32m Do $FUNCNAME ... Start\033[0m"
    sudo apt install python3-dev python3-pip -y
    pip install ici
    echo -e "\033[32m Do $FUNCNAME ... End\033[0m"
}

Vim(){
    echo -e "\033[32m Do $FUNCNAME ... Start\033[0m"

	bash -c "$(curl -fsSL https://raw.githubusercontent.com/lisider/.vim/master/config_vim.sh)"

    echo -e "\033[32m Do $FUNCNAME ... End\033[0m"
}

BaseConf(){
    Timing
    Samba
    Vsftpd
    Nfs
    AutoNfs
    Tmux
    Ssh
    Trash
    Bd
    Cheat
    MkdirDirectory
    Fish
    TheFuck
    Ici
    Vim
    Zsh
}
