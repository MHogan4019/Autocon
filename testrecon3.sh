#!/usr/bin/env bash

mainmenu() {
    echo -ne "
How would you like to use tshark?
1) Read Packet Data
2) Most Frequent Source IP
3) Most Frequent Destination IP
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

saveoptions() {
	echo -ne "
Save to file?
1) Yes
2) No
Choose an option: " 

	read -r ans
	case $ans in 
	1)
		tshark -r $Pcap > packet_data.txt
		echo "Saved to file! -> packet_data"
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
                tshark -r $pcap2 -T fields -e ip.src | sort | uniq -c | sort -n > Most_Src_IP.txt
                echo "Saved to file! -> Most_Src_IP"
                reportoptions
                ;;

        2)
                tshark -r $pcap2 -T fields -e ip.src | sort | uniq -c | sort -n
		reportoptions
                ;;
	esac
}

mainmenu
