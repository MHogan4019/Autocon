#!/bin/bash

mainmenu() {
	echo -ne "
MAIN MENU
1)Tshark
2)NMAP
0)Exit
Choose an option:  "
	read -r ans
	case $ans in
	1)
		mainmenu
		;;
	2)	nmapmenu
		;;
	0)
		echo "Bye bye."
		exit 0
		;;
	2106)
		secret
		;;
	*)
		echo "Wrong option"
		mainmenu
		;;
	esac
}

nmapmenu() {
	echo -ne "
NMAP
What is the IP? "
	read -r
	ip=$REPLY
	nmapoptions
} 

nmapoptions() {
	echo -ne "
NMAP
1)Create Report
2)OS and Services
3)Port
4)Ping
5)Show Hosts
6)Security Scans
0)Exit
What do you want to find? "
	read -r ans
	case $ans in
	1)
		nmap -sS -T4 -A -sC -oA report --webxml $ip
		exit 0
		;;
	2)
		os
		;;
	esac
}
os() {
	echo -ne "
OS and Services
1)Both
2)Just OS
3)Just Services
"
	read -r ans
	case $ans in
	1)
		nmap -A $ip
		os
		;;
	2)
		nmap -O $ip
		os
		;;
	3)	nmap -sV $ip
		os
		;;
	esac
}

mainmenu





