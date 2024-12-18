#!/bin/bash
#
# Copyright (c) 2012-2024 Di-gi Gen <https://vectordigi.cc>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/JKSTAFF/match_complier
# File name: postfix.sh
# Description: OpenWrt customize script phase 2 (After Update feeds)
#

# Change default locale
if [ `grep -c  "CONFIG_LUCI_LANG_zh_Hans=y" ".config"` -ne '0' ]; then 
    sed -i 's/UTC/CST-8/g' package/base-files/files/bin/config_generate
    sed -i '/CST-8/a\set system.@system[-1].zonename='"'"'Asia/Shanghai'"'"'' package/base-files/files/bin/config_generate
    echo "Localized for mainland China."
fi

# Wireless autorun
sed -i 's/0 : 1/1 : 0/g' package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc
echo "Wi-Fi will turn on, please set password promptly"

# Set default password for root
sed -i 's*root:::0:99999:7:::*root:\$1\$Z5PSAHJ9$1UReP9Mm94CqDFVEnROB//:17713:0:99999:7:::*g' package/base-files/files/etc/shadow
echo "Use 'toor' as the root password."

# Add  3rd-part packages
git clone -b packages-24.10 https://github.com/JKSTAFF/match_complier.git package/custom --recurse-submodules

# Add BBR TCP congestion control
if [ `grep -c  "CONFIG_PACKAGE_kmod-tcp-bbr=y" ".config"` -ne '0' ]; then 
    echo "net.core.default_qdisc=fq" >> package/base-files/files/etc/sysctl.conf
    echo "net.ipv4.tcp_congestion_control=bbr" >> package/base-files/files/etc/sysctl.conf
    echo "BBR activated due to the kernel module settings."
fi

# Increase UDP buffer
echo "net.core.rmem_max=16777216" >> package/base-files/files/etc/sysctl.conf && echo "net.core.wmem_max=16777216" >> package/base-files/files/etc/sysctl.conf
echo "Increase UDP buffer to 16M"

# Modify default gaewayIP
sed -i 's/192.168.1/192.168.0/g' package/base-files/files/bin/config_generate

# Switch off xray proxy by default
if [ `grep -c  "CONFIG_PACKAGE_luci-app-xray=y" ".config"` -ne '0' ]; then 
    sed -i 's/1/0/g' package/custom/luci-app-xray/core/root/etc/config/xray_core
    echo "Switch off xray proxy by default due to the package choice."
fi
