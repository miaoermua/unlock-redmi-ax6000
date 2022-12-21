###
 # @Author: ttimochan
 # @Date: 2022-12-21 21:16:34
 # @LastEditors: ttimochan
 # @LastEditTime: 2022-12-21 21:59:46
 # @FilePath: /unlock-redmi-ax6000/setup.sh
### 
#!/bin/bash
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root user"
    exit 1
fi
nvram_set(){
    echo -e 'admin\nadmin' | passwd root
    nvram set ssh_en=1
    nvram set telnet_en=1
    nvram set uart_en=1
    nvram set boot_wait=on
    nvram commit
}
set_init(){
    sed -i 's/channel=.*/channel="debug"/g' /etc/init.d/dropbear
    /etc/init.d/dropbear restart
}
uci_readly(){
    mkdir /data/auto_ssh
    cd /data/auto_ssh
    curl -O https://fastly.jsdelivr.net/gh/lemoeo/AX6S@main/auto_ssh.sh
    if [ ! -f auto_ssh.sh ]; then
        echo "Error: auto_ssh.sh download failed"
        exit 1
    fi
    chmod +x auto_ssh.sh
}
uci_start(){
    uci set firewall.auto_ssh=include
    uci set firewall.auto_ssh.type='script'
    uci set firewall.auto_ssh.path='/data/auto_ssh/auto_ssh.sh'
    uci set firewall.auto_ssh.enabled='1'
    uci commit firewall
    uci set system.@system[0].timezone='CST-8'
    uci set system.@system[0].webtimezone='CST-8'
    uci set system.@system[0].timezoneindex='2.84'
    uci commit
}
main(){
    
    nvram_set

    if [ $(nvram get ssh_en) != "1" ]; then
        echo "Error: nvram_set failed"
        exit 1
    fi 

    set_init

    if [ $(ps | grep dropbear | grep -v grep | wc -l) == "0" ]; then
        echo "Error: set_init failed"
        exit 1
    fi

    uci_readly

    if [ ! -f /data/auto_ssh/auto_ssh.sh ]; then
        echo "Error: uci_readly failed"
        exit 1
    fi
    uci_start

    if [ $(uci show firewall | grep auto_ssh | wc -l) == "0" ]; then
        echo "Error: uci_start failed"
        exit 1
    fi
    mtd erase crash

    echo "all works done!"
    sleep 1
    echo "reboot 1 second later"
    reboot
}
main