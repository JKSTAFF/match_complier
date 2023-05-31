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

# Wireless autorun
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# Set default password for root
sed -i 's*root::0:0:99999:7:::*root:\$1\$Z5PSAHJ9$1UReP9Mm94CqDFVEnROB//:17713:0:99999:7:::*g' package/base-files/files/etc/shadow
echo "Use 'toor' as the root password."

# Add  3rd-part packages
git clone -b packages https://github.com/JKSTAFF/match_complier.git package/custom
echo "Download 3rd-part packages into custom folder."

# Add BBR TCP congestion control
echo "net.core.default_qdisc=fq" >> package/base-files/files/etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> package/base-files/files/etc/sysctl.conf
echo "BBR activated."

# Modify default gaewayIP
#sed -i 's/192.168/172.16/g' package/base-files/files/bin/config_generate
#sed -i 's/172.16.1/172.16.0/g' package/base-files/files/bin/config_generate