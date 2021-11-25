#!/bin/bash
#
# Copyright (c) 2012-2020 Vector Di-gi <https://vectordigi.cf>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/JKSTAFF/match_complier
# File name: postfix.sh
# Description: OpenWrt customize script phase 2 (After Update feeds)
#

# Change default locale
sed -i 's/auto/zh_cn/g' feeds/luci/modules/luci-base/root/etc/config/luci
sed -i 's/UTC/CST-8/g' package/base-files/files/bin/config_generate
sed -i '/CST-8/a\set system.@system[-1].zonename='"'"'Asia/Shanghai'"'"'' package/base-files/files/bin/config_generate
echo "Change locale to China. You still need to install luci language pack manually."

# Wireless autorun
#sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i  '/exit 0/i\ifconfig ra0 up && brctl addif br-lan ra0\nifconfig rax0 up && brctl addif br-lan rax0' package/base-files/files/etc/rc.local
echo "Wi-Fi will turn on automaticly."

# Set default password for root
sed -i 's*root::0:0:99999:7:::*root:\$1\$Z5PSAHJ9$1UReP9Mm94CqDFVEnROB//:17713:0:99999:7:::*g' package/base-files/files/etc/shadow
echo "Use 'toor' as the root password."

# Add  3rd-part packages
git clone -b packages https://github.com/JKSTAFF/match_complier.git package/custom
echo "Download 3rd-part packages into custom folder."

# Add Fullcone-NAT option
sed -i '/Netfilter flow offload support/i\o = s.option(form.Flag, '"'"'fullcone'"'"', _('"'"'Enable FullCone-NAT'"'"'));'  feeds/luci/applications/luci-app-firewall/htdocs/luci-static/resources/view/firewall/zones.js
sed -i '/Uncomment this line to disable ipv6 rules/i\option fullcone		0' package/network/config/firewall/files/firewall.config
mkdir package/network/config/firewall/patches/
wget -P package/network/config/firewall/patches/ https://github.com/Lienol/openwrt/raw/main/package/network/config/firewall/patches/fullconenat.patch
#wget -P target/linux/generic/hack-5.4/  https://github.com/Lienol/openwrt/raw/main/target/linux/generic/hack-5.4/952-net-conntrack-events-support-multiple-registrant.patch
#wget -P target/linux/generic/hack-5.10/  https://github.com/Lienol/openwrt/raw/main/target/linux/generic/hack-5.10/952-net-conntrack-events-support-multiple-registrant.patch
echo "Add Fullcone-NAT option for firewall GUI. "

# Modify default gaewayIP
#sed -i 's/192.168/10.0/g' package/base-files/files/bin/config_generate
#sed -i 's/10.0.1/10.0.0/g' package/base-files/files/bin/config_generate
#echo "Set '10.0.0.1' as gateway."

# Enable MIPS FPU emulator
#if grep -q 'CONFIG_TARGET_ramips=y' .config  &&  ! grep -q 'CONFIG_KERNEL_MIPS_FP_SUPPORT=y' .config ;
#then 
#    echo "CONFIG_KERNEL_MIPS_FP_SUPPORT=y" >> .config && echo "FPU emulator enabled. Do not modify menuconfig again."
#else echo "Not MIPS architecture or parameter already exist. Skip"
#fi