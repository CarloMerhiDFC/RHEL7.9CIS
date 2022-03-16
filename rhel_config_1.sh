#!/bin/sh

BLUE='\033[1;35m'
RED='\033[1;31m'

echo
echo -e "${BLUE}Installing BigFix Client"
mkdir /etc/opt/BESClient/
rpm -ivh 'https://software.bigfix.com/download/bes/100/BESAgent-10.0.5.50-rhe6.x86_64.rpm'
cd /etc/opt/BESClient/
curl 'http://bigfix.dfc.gov:52311/masthead/masthead.afxm' -o actionsite.afxm
cd /etc/init.d/
./besclient start
cd /etc/systemd/system
systemctl enable besclient

echo
echo -e "${BLUE}Configuring Firewall for BigFix"
firewall-cmd --add-port=52311/tcp --permanent
firewall-cmd --add-port=52311/udp --permanent
firewall-cmd --list-services
systemctl stop firewalld
systemctl start firewalld
firewall-cmd --list-ports

echo
echo -e "${BLUE}Restarting BigFix"
systemctl stop besclient
systemctl start besclient
systemctl status besclient

echo
echo -e "${RED}Restarting System in 1 minutes"
shutdown -r +1
