#!/bin/sh
#
#settings on router using ipv6nat
#DevoutPrayer
#2019.9.18.16:19
#-------------install wget----------------
opkg update
opkg install libustream-openssl ca-bundle ca-certificates
#-----------change ipv6 prefix------------
uci set network.globals.ula_prefix="$(uci get network.globals.ula_prefix | sed 's/^./d/')"
uci commit network
#-----------------------------------------
uci set dhcp.lan.ra_default='1'
uci commit dhcp 
#-----------------------------------------
wget https://raw.github.com/DevoutPrayer/ShellScripts/master/Openwrt/nat6 -O /etc/init.d/nat6
chmod +x /etc/init.d/nat6
/etc/init.d/nat6 enable
#-----------------------------------------
#close Allow-ICMPv6-Forward
uci set firewall.@rule["$(uci show firewall | grep 'Allow-ICMPv6-Forward' | cut -d'[' -f2 | cut -d']' -f1)"].enabled='0'
uci commit firewall
#-----------------------------------------
#change /etc/sysctl.conf
echo -e "\nnet.ipv6.conf.default.forwarding=2\nnet.ipv6.conf.all.forwarding=2\nnet.ipv6.conf.default.accept_ra=2\nnet.ipv6.conf.all.accept_ra=2" >> /etc/sysctl.conf
#-----------------------------------------
#Download&Run scripts 
cd /usr
mkdir ipv6Settings
cd /ipv6Settings
wget https://raw.github.com/DevoutPrayer/ShellScripts/master/Openwrt/ipv6Init.sh
chmod +x ipv6Init.sh
./ipv6Init.sh
