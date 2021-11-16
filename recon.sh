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
                                        options=("Create Report" "OS and Services" "Port" "Ping" "Show Hosts" "Security Scans" "QUIT")
                                        select answer in "${options[@]}"; do
                                                case $answer in
							"Create Report")
								nmap -sS -T4 -A -sC -oA report --webxml $ip 
								;; 
                                                        "OS and Services") options3=("Both" "Just OS" "Just Services")
                                                                select answer in "${options3[@]}"; do
									case $answer in
										"Both")
											nmap -A $ip
											;;
										"Just OS")
											nmap -O $ip
											;;
										"Just Services")
											nmap -sV $ip
											;;
									esac
								done
                                                                ;;
							"Port") 
								echo "Port Scan With Auto Port Escalation (Nikto)"
								options2=("All" "Just TCP" "Just UDP")
								select answer in "${options2[@]}"; do
									case $answer in
										"All")
											nmap -p- -sU -sT $ip
												if nmap -sT $ip | grep -w "80/tcp"
                                                                                                then    
                                                                                                        nikto -host $ip
                                                                                                fi  
											;;
										"Just TCP")
											nmap -sT $ip 
												if nmap -sT $ip | grep -w "80/tcp"
												then 
													nikto -host $ip
												fi
											;;
										"Just UDP")
											nmap -sU $ip
												if nmap -sT $ip | grep -w "80/tcp"
                                                                                                then    
                                                                                                        nikto -host $ip
                                                                                                fi  
											;;
									esac
								done
								;;
							"Ping")
								nmap -sn $ip
								;;
							"Show Hosts") optionsh=("Online Hosts" "All Hosts")
								select answer in "${optionsh[@]}"; do
									case $answer in
										"Online Hosts")
											nmap -sL $ip
											;;
										"All Hosts")
											nmap -Pn $ip
											;;
									esac
								done
								;;
							"Security Scans") optionss=("Firewall Detection" "Malware Scan" "Vulnerability Scan")
								select answer in "${optionss[@]}"; do
									case $answer in
										"Firewall Detection")
											nmap -sA $ip
											;;
										"Malware Scan")
											nmap -sV --script =http-malware-host $ip
											;;
										"Vulnerability Scan")
											nmap -Pn --script vuln $ip
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

