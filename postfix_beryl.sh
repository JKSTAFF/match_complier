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
#sed -i  '/exit 0/i\ifconfig ra0 up && brctl addif br-lan ra0\nifconfig rax0 up && brctl addif br-lan rax0' package/base-files/files/etc/rc.local

# Set default password for root
sed -i 's*root:::0:99999:7:::*root:\$1\$Z5PSAHJ9$1UReP9Mm94CqDFVEnROB//:17713:0:99999:7:::*g' package/base-files/files/etc/shadow
echo "Use 'toor' as the root password."

# Add  3rd-part packages
git clone -b packages-25.12 https://github.com/JKSTAFF/match_complier.git package/custom

# Deprecated
# Add Fullcone-NAT option
# sed -i '/Netfilter flow offload support/i\o = s.option(form.Flag, '"'"'fullcone'"'"', _('"'"'Enable FullCone-NAT'"'"'));'  feeds/luci/applications/luci-app-firewall/htdocs/luci-static/resources/view/firewall/zones.js
# sed -i '/Uncomment this line to disable ipv6 rules/i\option fullcone		0' package/network/config/firewall/files/firewall.config
# mkdir package/network/config/firewall/patches/
# wget -P package/network/config/firewall/patches/ https://github.com/Lienol/openwrt/raw/21.02/package/network/config/firewall/patches/fullconenat.patch
#wget -P target/linux/generic/hack-5.4/  https://github.com/Lienol/openwrt/raw/main/target/linux/generic/hack-5.4/952-net-conntrack-events-support-multiple-registrant.patch
# Add Wireless fast forwarding
# echo "Applying Natflow patches... "
# wget -P target/linux/ramips/patches-5.4/ https://github.com/x-wrt/x-wrt/raw/21.10/target/linux/ramips/patches-5.4/990-mtk-driver-hwnat-compat-with-natflow.patch
# wget -P target/linux/ramips/patches-5.4/ https://github.com/x-wrt/x-wrt/raw/21.10/target/linux/ramips/patches-5.4/991-mtk_eth_soc-get-full-tag-info-from-rxd3.patch
# wget -P target/linux/ramips/files/drivers/net/ethernet/ralink/ https://github.com/x-wrt/x-wrt/raw/21.10/target/linux/ramips/files/drivers/net/ethernet/ralink/mtk_offload.h
# wget -P target/linux/ramips/files/drivers/net/ethernet/ralink/ https://github.com/x-wrt/x-wrt/raw/21.10/target/linux/ramips/files/drivers/net/ethernet/ralink/mtk_offload.c
# wget -P target/linux/mediatek/patches-5.4/ https://github.com/x-wrt/x-wrt/raw/21.10/target/linux/mediatek/patches-5.4/1100-mtk-driver-hwnat-compat-with-natflow.patch
# wget -P target/linux/mediatek/patches-5.4/ https://github.com/x-wrt/x-wrt/raw/21.10/target/linux/mediatek/patches-5.4/1101-mtk_eth_soc-get-full-tag-info-from-rxd3.patch
# wget -P target/linux/mediatek/patches-5.4/ https://github.com/x-wrt/x-wrt/raw/21.10/target/linux/mediatek/patches-5.4/9000-dts-mt7622-bpi-r64-aliases-for-dtoverlay.patch
# rm -rf target/linux/generic/pending-5.4/770-15-net-ethernet-mediatek-mtk_eth_soc-add-support-for-in.patch && wget -P target/linux/generic/pending-5.4/ https://github.com/x-wrt/x-wrt/raw/21.10/target/linux/generic/pending-5.4/770-15-net-ethernet-mediatek-mtk_eth_soc-add-support-for-in.patch
# echo "Attention: Natflow is NOT compatible with USB storage kmod."
# Enable MIPS FPU emulator
# if grep -q 'CONFIG_TARGET_ramips=y' .config  &&  ! grep -q 'CONFIG_KERNEL_MIPS_FP_SUPPORT=y' .config ;
# then 
#   echo "CONFIG_KERNEL_MIPS_FP_SUPPORT=y" >> .config && echo "FPU emulator enabled. Do not modify menuconfig again."
# else echo "Not MIPS architecture or parameter already exist. Skip"
#fi