# match_complier
>Custom OpenWrt complier for GL-MT1300  

## Why this variant
This repo using github actions to complile firmware for my GL.iNet Beryl(GL-MT1300) , which is minimum-obtrusive to the latest stable version of OpenWrt but only optimize for console game accelerator use. It's a reasonable product positioning for a low-end(mt7621) router.  
With that said it's fine to use it complile for other routers in [support list](https://openwrt.org/toh/start).  

## Main features  
* Integrated with MediaTek's non-free WiFi modules and fullcone-NAT support to improve connection quality
* Multiple WAN function allows you to increase the net speed exponentially  
* Build your own global transit between the router and private server. Xray is recommended due to its [ low CPU cost](https://github.com/v2ray/v2ray-core/issues/2636) and [UDP support](https://github.com/XTLS/Xray-core/discussions/252) as claimed  
* Only the hosting download and smb server function are retained on the USB port and SD card slot  
* Using nginx to provide luci and other web page over https. Remote access also available  
* HomeAssistant [intergration](https://www.home-assistant.io/integrations/luci/) compatible

## Usage  
1. Generate `.config` files with [stock repository](https://github.com/openwrt/openwrt/tree/openwrt-21.02) source code and overwrite it if you don't buy our default package set. You can also change the source code through environment variables in the workflow file  
2. Add 3rd-part packages to [this branch](https://github.com/Vector-Digi/match_complier/tree/packages) whatever you want  
3. Modify `prefix.sh` and `postfix.sh` to apply custom settings  
4. Select `Build OpenWrt` on the Actions page, then lick the `Run workflow` button  
5. When the build is complete, click the `Artifacts` button in the upper right corner of the Actions page to download the binaries  
6. [Flash](https://git.openwrt.org/?p=openwrt/openwrt.git;a=commit;h=d89a7f0120db42d4fae1656e1860ef49523acabb) and enjoy!  
p.s. Use **toor** as the default password  
