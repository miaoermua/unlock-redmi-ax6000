###
 # @Author: ttimochan
 # @Date: 2022-12-21 22:09:11
 # @LastEditors: ttimochan
 # @LastEditTime: 2022-12-21 22:34:26
 # @FilePath: /unlock-redmi-ax6000/uboot.sh
### 
#!/bin/bash
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root user"
    exit 1
fi
download_file(){
    cd /tmp
    curl -O https://ghproxy.com/https://github.com/hanwckf/bl-mt798x/releases/download/20221201/mt7986_redmi_ax6000-fip-fixed-parts.bin
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
main(){
    download_file
    check_file
    echo "download_file and check_file success"
    backup
    if [ ! -f /tmp/mtd4_Factory.bin ] || [ ! -f /tmp/mtd5_FIP.bin ]; then
        echo "Error: backup failed"
        exit 1
    fi
    echo "Backup success! Please download it to your computer"
    echo "Factory: /tmp/mtd4_Factory.bin"
    echo "FIP: /tmp/mtd5_FIP.bin"

}
main