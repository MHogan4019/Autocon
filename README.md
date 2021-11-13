# 2106-automatrecon
Automated recon tool


echo "What is your sudo password?"
stty_orig=$(stty -g)
stty -echo
read -r PASSWORD
stty "$stty_orig"
echo $PASSWORD | sudo nmap -sU
