#!/bin/bash
echo "How would you like to use tshark?"
        options1=("Read packet data" "Most frequent source IP" "Most frequent destination IP" "Other")
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
                                 "Other")
					echo  "do you want to exit"
					options=("no" "yes")
					select answer in "${options[@]}"; do
						case $answer in 
							"no")
								echo "What would you like to do next?"
								options=("Run another report")
								select answer2 in "${options[@]}"; do
									case $answer2 in
										"Run another report")
											$0
											;;
							"yes")
								exit 0;;
									esac
								done 
                                                esac
                                        done
			esac
		done

