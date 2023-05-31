# match_complier for Beryl
>Custom OpenWrt complier for GL-MT1300  

## Why this variant
This branch using github actions to complile firmware for my GL.iNet Beryl(GL-MT1300) , which is minimum-obtrusive to the latest stable version of OpenWrt but only optimize for console game accelerator use. It's a reasonable product positioning for a low-end(mt7621) router.  
With that said it's fine to use it complile for other routers in [support list](https://openwrt.org/toh/start).  

## Main features with my config  
* Integrated with wlan offload optimization and fullcone-NAT support to improve connection quality
* Multiple WAN function allows you to increase the net speed exponentially  
* Transparent proxy to your private server with fully configurable webui. Xray is recommended due to its [low CPU cost](https://github.com/v2ray/v2ray-core/issues/2636) and [UDP support](https://github.com/XTLS/Xray-core/discussions/252) as claimed  
* Fully support LTE modules on USB port  
* Using nginx to provide luci and other web page over https with ddns remote access

## How to use  
1. Generate `.config` files with [stock repository](https://github.com/openwrt/openwrt/tree/openwrt-21.02) source code and overwrite it if you don't buy our default package set. You can also change the source code through environment variables in the workflow file  
2. Add 3rd-part packages to [this branch](https://github.com/Vector-Digi/match_complier/tree/packages) whatever you want  
3. Modify `prefix.sh` and `postfix.sh` to apply custom settings  
4. Select `Build OpenWrt` on the Actions page, then lick the `Run workflow` button  
5. When the build is complete, click the `Artifacts` button in the upper right corner of the Actions page to download the binaries  
6. [Flash](https://git.openwrt.org/?p=openwrt/openwrt.git;a=commit;h=d89a7f0120db42d4fae1656e1860ef49523acabb) and enjoy!  
p.s. Use **toor** as the default password  
