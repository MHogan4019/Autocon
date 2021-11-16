#!/bin/bash
echo "How would you like to use tshark?"
        options1=("Read packet data" "Most frequent source IP" "Most frequent destination IP")
                select answer1 in "${options1[@]}"; do
                        case $answer1 in
                                "Read packet data")
                                        read -r -p "PCAP file: "
                                        locate $REPLY
                                        tshark -r $REPLY
                                        ;;
				"Most frequent source IP")
					read -r -p "PCAP file: "
					locate $REPLY
					tshark -r $REPLY -T fields -e ip.src | sort | uniq -c | sort -n
					;;
				"Most frequent destination IP")
					read -r -p "PCAP file: "
					locate $REPLY
					tshark -r $REPLY -T fields -e ip.dst | sort | uniq -c | sort -n
					;;

                                  "QUIT")
                                                                exit
                                                esac
                                        done

                        esac
                done

