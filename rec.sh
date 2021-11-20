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
		leave
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
	3)
		port
		;;
	4)
		nmap -sn $ip
		exit 0
		;;
	5)
		showhosts
		;;
	6)
		security
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

port() {
	echo -ne "
Port
1)All
2)Just TCP
3)Just UDP
Port Scan "
	read -r ans
	case $ans in
	1)
		nmap -p- -sU -sT $ip
			if nmap -p- -sU -sT $ip | grep -w "80/tcp"
			then 
				nikto -host $ip
			fi
		;;
	2)
		nmap -sT $ip
			if nmap -sT $ip | grep -w "80/tcp"
			then
				nikto -host $ip
			fi
		;;
	3)
		nmap -sU $ip
			if nmap -sU $ip | grep -w "80/tcp"
			then
				nikto -host $ip
			fi
		;;
	esac
}

showhosts() {
	echo -ne "
Show Hosts
1)Online Hosts
2)All Hosts
"
	read -r ans
	case $ans in
	1)
		nmap -sL $ip
		;;
	2)
		nmap -Pn $ip
		;;
	esac
}

security() {
	echo -ne "
Security Scans
1)Firewall Detection
2)Malware Scan
3)Vulnerability Scan
"
	read -r ans
	case $ans in
	1)
		nmap -sA $ip
		;;
	2)
		nmap -sV --script =http-malware-host $ip
		;;
	3)
		nmap -Pn --script vuln $ip
		;;
	esac
}

mainmenu

