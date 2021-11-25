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
		tsharkmenu
		;;
	2)	nmapmenu
		;;
	0)
		echo "Time to refuel..."
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
1)Check Local Network
2)Enter IP
Choose an option "
	read -r ans
	case $ans in
	1)
		ip addr show
		arp -a 
		nmapmenu
		;;
	2)
		getip
		nmapoptions
		;;
	esac
} 

getip() {
	echo -ne "
What is the IP? "
	read -r
	ip=$REPLY
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

tsharkmenu() {
    echo -ne "
How would you like to use tshark?
1) Read Packet Data
2) Most Frequent Source IP
3) Most Frequent Destination IP
4) Capture Data
0) Exit
Choose an option: "
	read -r ans
	case $ans in
	1)
		packetdatamenu
		;;
	2)
		ipsourcemenu
		;;
	3)
		ipdestinationmenu
		;;
	4)
		capturedatamenu
		;;
	0)
        	echo "Bye bye."
		exit 0
		;;
	*)
		echo "Wrong option."
		mainmenu
		;;
	esac
}

packetdatamenu() {
	echo -ne "
Read Packet Data 
What is the Pcap File? " 
	read -r 
	Pcap=$REPLY
	saveoptions
}

savename() {
	echo -ne "
What would you like to name the file? "

	read -r 
	file=$REPLY
}

saveoptions() {
	echo -ne "
Save to file?
1) Yes
2) No
Choose an option: " 

	read -r ans
	case $ans in 
	1)
		savename
		tshark -r $Pcap > $file.txt
		reportoptions
		;;
	2)
		tshark -r $Pcap
		reportoptions
		;;
	esac
}

reportoptions() {
	echo -ne "
Would you like to run another report?
1) Yes
2) No 
Choose an option: "

	read -r ans
	case $ans in
	1)
		mainmenu
		;;
	2)
		echo "Bye bye."
		exit 0
		;;
	esac
}

ipsourcemenu() {
	echo -ne "
Most frequent IP Address 
What is the Pcap file? "
	read -r
	pcap2=$REPLY
        saveoptions2
}

saveoptions2() {
        echo -ne "
Save to file? 
1) Yes
2) No 
Choose an option: "

        read -r ans
        case $ans in 
        1)
		savename
                tshark -r $pcap2 -T fields -e ip.src | sort | uniq -c | sort -n > $file.txt  
                reportoptions
                ;;

        2)
                tshark -r $pcap2 -T fields -e ip.src | sort | uniq -c | sort -n
		reportoptions
                ;;
	esac
}

ipdestinationmenu() {
	 echo -ne "
Most frequent IP Address 
What is the Pcap file? "
        read -r
        pcap2=$REPLY
        saveoptions3

}
saveoptions3() {
	echo -ne "
Save to file?
1) Yes
2) No
Choose an option: "

	read -r ans
	case $ans in 
	1)
		savename
		tshark -r $pcap2 -T fields -e ip.dst | sort | uniq -c | sort -n > $file.txt
                reportoptions
		;;
	2)
		tshark -r $pcap2 -T fields -e ip.dst | sort | uniq -c | sort -n
                reportoptions
		;;
	esac
}

capturedatamenu() {
	echo -ne "
Enter the name of the file you would like to save your data: " 
	read -r
	Datafile=$REPLY
	echo -ne "
For how many seconds would you like to capture data: "
	read -r 
	duration=$REPLY
        tshark -a duration:$duration -w /tmp/$Datafile.pcap
	echo "File saved in /tmp directory"
}


title() {
	echo -ne "
Fueling System..."

speed


mainmenu
}


speed() {
	echo -ne '
------------------------------------------------
_______       _____
___    |___  ___  /_________________________
__  /| |  / / /  __/  __ \  ___/  __ \_  __ \
_  ___ / /_/ // /_ / /_/ / /__ / /_/ /  / / /
/_/  |_\__,_/ \__/ \____/\___/ \____//_/ /_/

Autocon 1.2
Forged by JAML-2106 Team
JAML2106Autocon@gmail.com

- - - - - - - - - - - - - - - - - - - - - - - -
'
}

title

