**解锁红米 AX6000 SSH 并且下载校验 u-boot 脚本**

解锁 SSH

```bash
cd /tmp && curl --silent -O https://fastly.jsdelivr.net/gh/miaoermua/unlock-redmi-ax6000@main/setup.sh && chmod +x setup.sh && ./setup.sh
```

准备 U-Boot 相关（非刷入）

```bash
cd /tmp && curl --silent -O https://fastly.jsdelivr.net/gh/miaoermua/unlock-redmi-ax6000@main/uboot.sh && chmod +x uboot.sh && ./uboot.sh
```

## 详情

博客: https://www.miaoer.xyz/posts/network/flash-redmi-ax6000

视频: https://www.bilibili.com/video/BV1c24y1U79v

***

## 感谢

因为 hanwckf 删除了关于 20221201 版本的 UBOOT releases 所以这里保留了一份，后续有空会尝试最新的 UBOOT 并且编写为脚本方便安装使用。

@[ttimochan](https://github.com/ttimochan)

[U-Boot](https://github.com/hanwckf/bl-mt798x)

[auto_ssh](https://github.com/lemoeo/AX6S/blob/main/auto_ssh.sh)

[解锁 Telnet/SSH 教程](https://qust.me/post/ax6000-shellclash)

[刷入 U-Boot 教程](https://www.right.com.cn/forum/thread-8265832-1-1.html)

[解锁 SSH 权限](https://www.right.com.cn/forum/thread-8253125-1-1.html)
