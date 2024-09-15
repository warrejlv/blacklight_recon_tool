#!/bin/bash

# Function to check if a tool is installed, if not install it
check_and_install(){
    tool=$1
    install_cmd=$2
    if ! command -v $tool &> /dev/null; then
        echo "$tool is not installed. Installing $tool..."
        sudo $install_cmd
		if [ $? -ne 0 ]; then
		    echo "Error: Failed to install $tool"
			exit 1
		fi 
    else
        echo "$tool is already installed."
    fi
}

# install all required tools 
install_required_tools(){
    echo "Checking for required tools and installing if missing..."
	
	# pip install 
	if ! command -v pip &> /dev/null; then
	   echo "pip is not installed. Installing pip..."
	   sudo apt update
	   sudo apt install python3-xyz
	   sudo apt install -y pip
	   if [ $? -ne 0 ]; then 
	      echo "Error: Failed to installed pip"
		  exit 1
	   fi 
   else
        echo "pip is already installed."
   fi 

    # Function to ensure all required tools are installed

    check_and_install "nmap" "apt-get install -y nmap"
    check_and_install "masscan" "apt-get install -y masscan"
    check_and_install "zmap" "apt-get install -y zmap"
    check_and_install "dnsenum" "apt install -y dnsenum"
    check_and_install "dnsrecon" "apt-get install -y dnsrecon"
    check_and_install "gobuster" "apt-get install -y gobuster"
    check_and_install "dirb" "apt-get install -y dirb"
    check_and_install "wfuzz" "apt-get install -y wfuzz"
    check_and_install "dig" "apt-get install -y dnsutils"
	check_and_install "traceroute" "apt-get install -y traceroute"
    check_and_install "whois" "apt-get install -y whois"
}


# main menu

MainMenu(){
      clear
	  tput setaf 5 # set color to purple
      echo ""
	  echo ""
      echo "               ▄▄▄▄    ██▓    ▄▄▄       ▄████▄   ██ ▄█▀ ██▓     ██▓  ▄████  ██░ ██ ▄▄▄█████▓"
      echo "               ▓█████▄ ▓██▒   ▒████▄    ▒██▀ ▀█   ██▄█▒ ▓██▒    ▓██▒ ██▒ ▀█▒▓██░ ██▒▓  ██▒ ▓▒"
      echo "               ▒██▒ ▄██▒██░   ▒██  ▀█▄  ▒▓█    ▄ ▓███▄░ ▒██░    ▒██▒▒██░▄▄▄░▒██▀▀██░▒ ▓██░ ▒░"
      echo "               ▒██░█▀  ▒██░   ░██▄▄▄▄██ ▒▓▓▄ ▄██▒▓██ █▄ ▒██░    ░██░░▓█  ██▓░▓█ ░██ ░ ▓██▓ ░ "
      echo "               ░▓█  ▀█▓░██████▒▓█   ▓██▒▒ ▓███▀ ░▒██▒ █▄░██████▒░██░░▒▓███▀▒░▓█▒░██▓  ▒██▒ ░ "
      echo "               ░▒▓███▀▒░ ▒░▓  ░▒▒   ▓▒█░░ ░▒ ▒  ░▒ ▒▒ ▓▒░ ▒░▓  ░░▓   ░▒   ▒  ▒ ░░▒░▒  ▒ ░░ "  
      echo "               ▒░▒   ░ ░ ░ ▒  ░ ▒   ▒▒ ░  ░  ▒   ░ ░▒ ▒░░ ░ ▒  ░ ▒ ░  ░   ░  ▒ ░▒░ ░    ░ "   
      echo "                ░    ░   ░ ░    ░   ▒   ░        ░ ░░ ░   ░ ░    ▒ ░░ ░   ░  ░  ░░ ░  ░ "     
      echo "                ░          ░  ░     ░  ░░ ░      ░  ░       ░  ░ ░        ░  ░  ░  ░ "        
      echo "                ░                  ░ "                                                   
      echo ""
	  echo "                                                Recon Multitool"
	  echo "                                                                            iplaynojames"
	  echo ""
	  echo "          1. Network Scanning"
      echo "          2. DNS Enumeration & Subdomain Discovery"
      echo "          3. Service Enumeration"
      echo "          4. Port Scanning"
      echo "          5. Banner Grabbing"
      echo "          6. Content Discovery (Web)"
      echo "          7. IP/Domain Footprinting"
      echo "          0. Exit"
	  read -p        "Select an area (1-8 or 0 to Exit): " choice
	  
	  
	  case $choice in
	       1) NetworkScanning ;;
		   2) DNSEnum ;;
		   3) ServiceEnum ;;
		   4) PortScanning ;;
		   5) BannerGrabbing ;;
		   6) ContentDiscovery ;;
		   7) IPFootprinting ;;
		   0) exit ;;
		   *) MainMenu ;;
	  esac
}

# network scanning
 
NetworkScanning(){
       clear
	   echo "=========================================="
	   echo "          Network Scanning Tools"
	   echo "=========================================="
	   echo "1. Nmap (Full Port Scan)"
	   echo "2. Masscan (Fast Network Scan)"
	   echo "3. Zmap (Large Scale Scanning)"
	   echo "0. Back to Main Menu"
	   echo "=========================================="
	   read -p "Choose a tool to execute (1-3 or 0 to go back): " choice
	   
	   
	   case $choice in
	        1) 
			   read -p "Enter target IP or domain: " targetIP
			   nmap -sS -p- $targetIP ;;
			   
			2) 
			   read -p "Enter target IP range (e.g., 192.168.1.0/24): " targetRange
			   read -p "Enter scan rate (packets per second): " rate 
			   sudo masscan -p1-65535 $targetRange --rate $rate ;;
			3) 
			   read -p "Enter target IP range (e.g., 192.168.1.0/24): " targetRange 
			   sudo zmap -p 80 $targetRange ;;
			0) MainMenu ;;
			*) NetworkScanning ;;
	   esac
	   read -p "Press [Enter] key to continue..."
	   MainMenu
}


# dns enum and subdomain discovery 

DNSEnum(){
       clear
	   echo "==========================================="
	   echo "             DNS Enumeration"
	   echo "==========================================="
	   echo "1. DNSenum (DNS Enumeration)"
	   echo "2. DNSRecon (DNS Brute-Force)"
	   echo "0. Back to Main Menu"
	   echo "==========================================="
	   read -p "Choose a tool to execute (1-3 or 0 to go back): " choice
	   
	   case $choice in
	        1) 
		       read -p "Enter the domain for DNS enumeration: " domain 
			   dnsenum $domain ;; 
		    2) 
			   read -p "Enter the domain for DNS brute force: " domain 
               dnsrecon -d $domain ;;
            0) MainMenu ;;
            *) DNSEnum ;;
       esac
       read -p "Press [Enter] key to continue..."
       MainMenu 
}

	
# service enum 

ServiceEnum(){
    	clear 
		echo "========================================"
		echo "       Service Enumeration Tools"
		echo "========================================"
		echo "1. Nmap (Service Version Detection)"
		echo "2. NSE Scripts (Specific Service Detection)"
		echo "0. Back to Main Menu"
		echo "========================================"
		read -p "Choose a tool to execute (1-3 or 0 to go back): " choice 
		
		case $choice in 
		    1)
			    read -p "Enter the target IP for service version detection: " targetIP 
				nmap -sV $targetIP ;;
				
			2)  
			    read -p "Enter the NSE script name: " script
				read -p "Enter the port number: " port 
				read -p "Enter the target IP: " targetIP 
				nmap --script $script -p $port $targetIP ;;
			0) MainMenu ;;
			*) ServiceEnum ;;
		esac 
		read -p "Press [Enter] key to continue..."
		MainMenu 
}

# port scanning 

PortScanning(){
        clear
		echo "========================================="
		echo "           Port Scanning Tools"
		echo "========================================="
		echo "1. Nmap (Full Port Scan)"
		echo "2. Masscan (Fast Port Scan)"
		echo "0. Back to Main Menu"
		echo "========================================="
		read -p "Choose a tool to execute (1-2 or 0 to go back): " choice 
		
		case $choice in
		    1) 
			    read -p "Enter the target IP or domain for full port scan: " targetIP 
				nmap -p1-65535 $targetIP ;;
			2) 
			    read -p "Enter the target IP range: " targetRange 
				sudo masscan -p1-65535 $targetRange --rate 1000 ;;
			0) MainMenu ;;
			*) PortScanning ;;
		esac
		read -p "Press [Enter] key to continue..."
		MainMenu 
}

# banner grabbing 

BannerGrabbing(){
        clear
		echo "========================================="
		echo "          Banner Grabbing Tools"
        echo "========================================="
        echo "1. Netcat	(Manual Banner Grabbing)"
        echo "2. Telnet (Manual Banner Grabbing)"
        echo "3. Nmap (Banner Script)"
        echo "0. Back to Main Menu)"
        echo "========================================="
        read -p "Choose a tool to execute (1-3 or 0 to go back): " choice 

        case $choice in 
            1) 
                read -p "Enter the target IP: " targetIP 
                read -p "Enter the port number: " port 
                nc -v $targetIP $port ;; 
          	2) 
			    read -p "Enter the target IP: " targetIP 
				read -p "Enter the port number: " port 
				telnet $targetIP $port ;;
		    3) 
			    read -p "Enter the target IP: " targetIP 
				read -p "Enter the port number: " port 
				nmap --script banner -p $port $targetIP ;;
			0) MainMenu ;;
			*) BannerGrabbing ;;
		esac
		read -p "Press [Enter] key to continue..." 
		MainMenu
}


# content discovery (web) 

ContentDiscovery(){
        clear 
		echo "========================================="
		echo "       Web Content Discovery Tools" 
        echo "========================================="
		echo "1. Gobuster (Brute-force directories)"
		echo "2. Dirb (Directory Brute-force)"
		echo "3. Wfuzz (Web File/Directory Fuzzing)"
		echo "0. Back to Main Menu"
		echo "========================================="
		read -p "Choose a tool to execute (1-3 or 0 to go back): " choice 
		
		case $choice in 
		    1) 
			   read -p "Enter the target URL (e.g., http://example.com): " url 
			   read -p "Enter the wordlist path: " wordlist 
			   gobuster dir -u $url -w $wordlist ;;
			2) 
			   read -p "Enter the target URL (e.g., http://example.com): " url 
			   read -p "Enter the wordlist path: " wordlist 
			   dirb $url $wordlist ;;
			3) 
			   read -p "Enter the targer URL (e.g., http://example.com): " url 
			   read -p "Enter the wordlist path: " wordlist 
			   wfuzz -c -w $wordlist --hc 404 $url/FUZZ ;;
			0) MainMenu ;; 
			*) ContentDiscovery ;;
		esac
		read -p "Press [Enter] key to continue..."
		MainMenu 
}


# ip/domain footprinting
 
IPFootprinting(){
        clear
		echo "=============================================="
		echo "           IP/Domain Footprinting"
		echo "=============================================="
		echo "1. Whois (Domain Registration Info)"
		echo "2. Dig"
		echo "3. Nslookup" 
		echo "4. Traceroute" 
		echo "5. Nmap (IP Fingerprinting)"
		echo "0. Back to Main Menu" 
		echo "=============================================="
		read -p "Choose a tool to execute (1-2 or 0 to go back): " choice 
		
		case $choice in 
		    1) 
			   read -p "Enter the domain to get WHOIS info: " domain 
			   whois $domain ;;
			2) 
			   read -p "Enter the domain or IP for Dig: " domainIP
			   dig $domainIP ;;
			3) 
			   read -p "Enter the domain or IP for Nslookup: " domainIP 
			   nslookup $domainIP ;;
			4) 
			   read -p "Enter the domain or IP for Traceroute: " domainIP 
			   traceroute $domainIP ;;
			5)
			   read -p "Enter the target IP for Nmap fingerprinting: " targetIP 
			   nmap -O $targetIP ;; 
			0) MainMenu ;; 
			*) IPFootprinting ;;
		esac
		read -p "Press [Enter] key to continue..."
		MainMenu
}



# check for tools before start 

install_required_tools 

# start the multitool 

MainMenu 
