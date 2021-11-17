#!/bin/bash
echo "How would you like to use tshark?"
        options1=("Read packet data" "Most frequent source IP" "Most frequent destination IP" "Quit")
                select answer1 in "${options1[@]}"; do
                        case $answer1 in
                                "Read packet data")
                                        read -r -p "PCAP file: "
					pcap=$REPLY
                                        echo "Would you like to save to a file?"
                                        options=("yes" "no")
                                        select answer in "${options[@]}"; do
                                                case $answer in 
                                                        "yes")
                                                                 tshark -r $pcap  > packet_data
                                                                echo "Saved to file! -> packet_data"
								echo "Would you like to run another report?"
                                                                options=("yes" "no")
                                                                        select answer in "${options[@]}"; do
                                                                                case $answer in 
                                                                                        "yes")
                                                                                                $0 && exit
                                                                                                ;;
 
                                                                                        "no")
                                                                                         	exit 0 ;;
										esac
									done ;; 
                                                        "no")
                                                                tshark -r $pcap
								echo "Would you like to run another report?"
								options=("yes" "no")
                                        				select answer in "${options[@]}"; do
                                                				case $answer in 
                                                        				"yes")
                                                           					$0 && exit
                                                           					;;
                 				                                esac
                                        				 done ;;
                        				                                "no")
												exit 0 ;;
						esac
					done
					;;
				"Most frequent source IP")
					read -r -p "PCAP file: "
					pcap=$REPLY
                                        echo "Would you like to save to a file?"
                                        options=("yes" "no")
                                        select answer in "${options[@]}"; do
                                                case $answer in 
                                                        "yes")
                                                                tshark -r $pcap -T fields -e ip.src | sort | uniq -c | sort -n > Most_Src_IP
                                                                echo "Saved to file! -> Most_Src_IP"
								echo "Would you like to run another report?"
                                                                options=("yes" "no")
                                                                        select answer in "${options[@]}"; do
                                                                                case $answer in 
                                                                                        "yes")
                                                                                                $0 && exit
                                                                                                ;;
 
                                                                                        "no")
                                                                                                exit 0 ;;
                                                                                esac
                                                                        done ;;
                                                        "no")
                                                                tshark -r $pcap -T fields -e ip.src | sort | uniq -c | sort -n
                                                                echo "Would you like to run another report?"
                                                                options=("yes" "no")
                                                                        select answer in "${options[@]}"; do
                                                                                case $answer in 
                                                                                        "yes")
                                                                                                $0 && exit
                                                                                                ;;
                                                                                esac
                                                                         done ;;
                                                                                        "no")
                                                                                                exit 0 ;;
                                                esac
                                        done
					;;
				"Most frequent destination IP")
					read -r -p "PCAP file: "
					pcap=$REPLY
                                        echo "Would you like to save to a file?"
                                        options=("yes" "no")
                                        select answer in "${options[@]}"; do
                                                case $answer in 
                                                        "yes")
                                                                tshark -r $pcap -T fields -e ip.dst | sort | uniq -c | sort -n > Most_Dst_IP
                                                                echo "Saved to file! -> Most_Dst_IP"
                                                                echo "Would you like to run another report?"
                                                                options=("yes" "no")
                                                                        select answer in "${options[@]}"; do
                                                                                case $answer in 
                                                                                        "yes")
                                                                                                $0 && exit
                                                                                                ;;
 
                                                                                        "no")
                                                                                                exit 0 ;;
                                                                                esac
                                                                        done ;;
                                                        "no")
								tshark -r $pcap -T fields -e ip.src | sort | uniq -c | sort -n
                                                                echo "Would you like to run another report?"
                                                                options=("yes" "no")
                                                                        select answer in "${options[@]}"; do
                                                                                case $answer in 
                                                                                        "yes")  
                                                                                                $0 && exit
                                                                                                ;;
                                                                                esac
                                                                         done ;;
                                                                                        "no")
                                                                                                exit 0 ;;
                                                esac
                                        done
                                        ;;
                                 "Quit")
					echo  "Would you like to exit?"
					options=("no" "yes")
					select answer in "${options[@]}"; do
						case $answer in 
							"no")
								echo "What would you like to do next?"
								options=("Run another report?")
								select answer2 in "${options[@]}"; do
									case $answer2 in
										"Run another report?")
											$0 && exit
											;;
									esac
								done ;;
							"yes")
								exit 0 ;;
                                                esac
                                        done
			esac
		done

