#!/bin/bash

BLUE='\033[1;35m'
RED='\033[1;31m'

echo
echo -e "${BLUE}Installing BigFix Client"
mkdir /etc/opt/BESClient/
rpm -ivh 'https://software.bigfix.com/download/bes/100/BESAgent-10.0.5.50-rhe6.x86_64.rpm'
