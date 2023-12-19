###
 # @Author: ttimochan
 # @Date: 2022-12-21 22:09:11
 # @LastEditors: ttimochan
 # @LastEditTime: 2023-9-9 18:09:14
 # @FilePath: /unlock-redmi-ax6000/uboot.sh
### 
#!/bin/bash
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root user"
    exit 1
fi
download_file(){
    echo "echo \033[33mCopyright"
    echo "======================""
    echo "Official blog: https://www.miaoer.xyz/posts/network/flash-redmi-ax6000"
    echo "Read more at: miaoer.xyz"
    echo "======================"
    echo " "
    cd /tmp
    curl -O https://fastly.jsdelivr.net/gh/miaoermua/unlock-redmi-ax6000@main/mt7986_redmi_ax6000-fip-fixed-parts.bin
    if [ ! -f mt7986_redmi_ax6000-fip-fixed-parts.bin ]; then
        echo "Error: mt7986_redmi_ax6000-fip-fixed-parts.bin download failed"
        exit 1
    fi
}
check_file(){
    if [ $(md5sum mt7986_redmi_ax6000-fip-fixed-parts.bin | awk '{print $1}') != "7610a1722073748c3c3a860b75d94d5d" ]; then
        echo "Error: mt7986_redmi_ax6000-fip-fixed-parts.bin md5 is not correct"
        exit 1
    fi
}
backup(){
    dd if=/dev/mtd4 of=/tmp/mtd4_Factory.bin
    dd if=/dev/mtd5 of=/tmp/mtd5_FIP.bin
}
rm_self(){
    dir=$(pwd)
    file=$(basename $0)
    rm -rf $dir/$file
}
main(){
    download_file
    check_file
    echo -e "\033[32mdownload file and check file success\033[0m"  
    backup
    if [ ! -f /tmp/mtd4_Factory.bin ] || [ ! -f /tmp/mtd5_FIP.bin ]; then
        echo "Error: backup failed"
        exit 1
    fi
    
    echo "\033[32mSuccess!"
    echo "======================"
    echo -e "\033[31mBackup success! Please use SCP tool to download to your computer \033[0m"
    echo -e "\033[31mFactory: /tmp/mtd4_Factory.bin \033[0m"
    echo -e "\033[31mFIP: /tmp/mtd5_FIP.bin \033[0m"
    echo -e "\033[31mThis shell script will rm self \033[0m"
    rm_self
}
main
