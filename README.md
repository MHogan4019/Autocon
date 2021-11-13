# 2106-automatrecon
Automated recon tool


echo "What is your sudo password?"
stty_orig=$(stty -g)
stty -echo
read -r PASSWORD
stty "$stty_orig"
echo $PASSWORD | sudo nmap -sU

tshark -r network.pcap -T fields -e ip.src -e ip.dst | sort | uniq -c | sort -n

