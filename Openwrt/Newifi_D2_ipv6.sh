#!/bin/sh
#
#This Shell scripts is used to init ipv6 settings when the router start^*^
#DevoutPrayer
#2019-9-17 14:58
#-----------Test IPv4 Connection-------------
status=1
while test $status -ne 0
do
	ping -c1 www.baidu.com > /dev/null
	status=$?
done
echo `date` Ping www.baidu.com ----OK!
#----------Test IPv6 Connection--------------
status=1
while test $status -ne 0
do
	ping -c1 pt.hit.edu.cn > /dev/null
	status=$?
done
echo `date` Ping pt.hit.edu.cn ----Failed!

#-------------Set ip6tables-----------------
ip6tables -t nat -D POSTROUTING 1
ip6tables -t nat -I POSTROUTING -s $(uci get network.globals.ula_prefix) -j MASQUERADE

