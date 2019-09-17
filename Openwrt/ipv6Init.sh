#!/bin/sh
#
#This Shell Script is used to update Newifi_D2_ipv6.sh
#DevoutPrayer
#2019-9-17 14:59
#-----------Test IPv4 Connection-------------
status=1
while test $status -ne 0
do
	ping -c1 www.baidu.com > /dev/null
	status=$?
done
echo `date` Ping www.baidu.com ----OK!
#--------------------------------------------
VersionScriptsLocationLocal="./ShellScriptsVersion.local"
VersionScriptsLocationServer="./ShellScriptsVersion.server"
if test -e ${VersionScriptsLocationServer}
then
	cp ${VersionScriptsLocationServer} ${VersionScriptsLocationServer}".old"
	rm -f ${VersionScriptsLocationServer}
	echo `date` Copy ${VersionScriptsLocationServer}  ----OK!
else
	echo `date` ${VersionScriptsLocationServer} is not exists!
fi
wget https://raw.github.com/DevoutPrayer/ShellScripts/master/Openwrt/ShellScriptsVersion -O ${VersionScriptsLocationServer}

if test $? -eq 0
then
	rm -f ${VersionScriptsLocationServer}".old"
else
	cp ${VersionScriptsLocationServer}".old" ${VersionScriptsLocationServer}
	rm -f ${VersionScriptsLocationServer}".old"
fi

if test -e ${VersionScriptsLocationLocal}
then
	while read line
	do
		Newifi_D2_ipv6_ver=${line}
	done < ${VersionScriptsLocationLocal}
else
	echo "Newifi_D2_ipv6_ver=\"NULL\"" > ${VersionScriptsLocationLocal}
	
fi

equalIndex=`expr index "${Newifi_D2_ipv6_ver}" "=" `
equalIndex=`expr ${equalIndex} + 1 `
Newifi_D2_ipv6_ver_local=`expr substr "${Newifi_D2_ipv6_ver}" ${equalIndex} ${#Newifi_D2_ipv6_ver}`

while read line
do
	Newifi_D2_ipv6_ver=${line}
done < ${VersionScriptsLocationServer}
equalIndex=`expr index "${Newifi_D2_ipv6_ver}" "=" `
equalIndex=`expr ${equalIndex} + 1 `
Newifi_D2_ipv6_ver_server=`expr substr "${Newifi_D2_ipv6_ver}" ${equalIndex} ${#Newifi_D2_ipv6_ver}`
echo  Newifi_D2_ipv6_ver_local--${Newifi_D2_ipv6_ver_local}
echo  Newifi_D2_ipv6_ver_server-${Newifi_D2_ipv6_ver_server}

if test ${Newifi_D2_ipv6_ver_local} -eq ${Newifi_D2_ipv6_ver_server}
then
	echo ""
else
	if test -e Newifi_D2_ipv6.sh
	then
		cp Newifi_D2_ipv6.sh Newifi_D2_ipv6.sh.old
		rm -f Newifi_D2_ipv6.sh
	else
		echo `date` have not found Newifi_D2_ipv6.sh. 
	fi
	wget https://raw.github.com/DevoutPrayer/ShellScripts/master/Openwrt/Newifi_D2_ipv6.sh
	if test $? -eq 0
	then
		echo `date` Download Newifi_D2_ipv6.sh success.
	else
		cp Newifi_D2_ipv6.sh.old Newifi_D2_ipv6.sh
		rm -f Newifi_D2_ipv6.sh.old
		echo `date` Download Newifi_D2_ipv6.sh failed.
	fi
	if test -e Newifi_D2_ipv6.sh.old
	then
		rm -f Newifi_D2_ipv6.sh.old
	else
		echo `date` have not found Newifi_D2_ipv6.sh.old. 
	fi
	chmod +x Newifi_D2_ipv6.sh
	rm -f ${VersionScriptsLocationLocal}
	echo "Newifi_D2_ipv6_ver=${Newifi_D2_ipv6_ver_server}" > ${VersionScriptsLocationLocal}
fi
./Newifi_D2_ipv6.sh > ipv6_setting.log

