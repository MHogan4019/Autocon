#!/bin/bash
echo "What are you trying to do?"
        options1=("Tshark" "NMAP")
                select answer1 in "${options1[@]}"; do
                        case $answer1 in
                                "Tshark")
                                        read -r -p "PCAP file destination: "
                                        locate $REPLY
                                        tshark -r $REPLY
                                        ;;
                                "NMAP")
                                        read -r -p "What is the IP: "
                                        ip=$REPLY
                                        question='What do you want to find?: '
                                        options=("OS" "Port" "QUIT")
                                        select answer in "${options[@]}"; do
                                                case $answer in
                                                        "OS")
                                                                nmap -O $ip
                                                                ;;
							"Port") options2=("All" "Just TCP" "Just UDP")
								select answer in "${options2[@]}"; do
									case $answer in
										"All")
											nmap -p- -sU -sT $ip
											;;
										"Just TCP")
											nmap -sT $ip
											;;
										"Just UDP")
											nmap -sU $ip
											;;
									esac
								done
								;;
                                                        "QUIT")
                                                                exit
								;;
                                                esac
                                        done

                        esac
                done

