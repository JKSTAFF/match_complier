# match_complier
>Custom OpenWrt complier for multiple target  

## Why this variant
This branch using github actions to complile firmware for my routers, which is minimum-obtrusive to the stable version of official OpenWrt but only optimize for connection and home-lab usage.  
With that said it's fine to use it complile for other routers in [support list](https://openwrt.org/toh/start).  

## How to use  
1. Generate `.config` files with [stock repository](https://github.com/openwrt/openwrt/tree/openwrt-21.02) source code and overwrite it if you don't buy our default package set. You can also change the source code through environment variables in the workflow file  
2. Add 3rd-part packages to [this branch](https://github.com/Vector-Digi/match_complier/tree/packages) whatever you want  
3. Modify `prefix.sh` and `postfix.sh` to apply custom settings  
4. Select `Build OpenWrt` on the Actions page, then lick the `Run workflow` button  
5. When the build is complete, click the `Artifacts` button in the upper right corner of the Actions page to download the binaries  
6. [Flash](https://git.openwrt.org/?p=openwrt/openwrt.git;a=commit;h=d89a7f0120db42d4fae1656e1860ef49523acabb) and enjoy!  
p.s. Use **toor** as the default password  
