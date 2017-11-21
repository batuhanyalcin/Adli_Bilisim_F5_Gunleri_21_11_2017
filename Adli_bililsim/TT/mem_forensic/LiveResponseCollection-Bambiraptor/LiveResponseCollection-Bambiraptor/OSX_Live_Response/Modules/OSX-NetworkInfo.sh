#!/bin/bash

# Last updated 12 December 2016 by Brian Moran (brian@brimorlabs.com)
# Please read "ReadMe.txt" for more information regarding GPL, the script itself, and changes
# RELEASE DATE: 20161212
# AUTHOR: Brian Moran (brian@brimorlabs.com)
# TWITTER: BriMor Labs (@BriMorLabs)
# Version: Live Response Collection (Bambiraptor Build - 20161212)
# Copyright: 2013-2016, Brian Moran

# This file is part of the Live Response Collection
# The Live Response Collection is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
# Additionally, usages of all tools fall under the express license agreement stated by the tool itself.

modulesource=${BASH_SOURCE[0]}
modulename=${modulesource/$modulepath/}


echo ""
echo "** Now running $modulename module **"

printf "Command Run: netstat -an\n"
printf "Command Run: netstat -an\n" >> "$computername/$computername""_Processing_Details.txt"
netstat -an 1>> $computername/LiveResponseData/NetworkInfo/netstat_current_connections.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"


printf "Command Run: lsof -i\n"
printf "Command Run: lsof -i\n" >> "$computername/$computername""_Processing_Details.txt"
lsof -i 1>> $computername/LiveResponseData/NetworkInfo/lsof_network_connections.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"


printf "Command Run: scutil --dns\n"
printf "Command Run: scutil --dns\n" >> "$computername/$computername""_Processing_Details.txt"
scutil --dns 1>> $computername/LiveResponseData/NetworkInfo/DNS_Configuration.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"


printf "Command Run: netstat -rn\n"
printf "Command Run: netstat -rn\n" >> "$computername/$computername""_Processing_Details.txt"
netstat -rn 1>> $computername/LiveResponseData/NetworkInfo/Routing_table.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"


printf "Command Run: arp -an\n"
printf "Command Run: arp -an\n" >> "$computername/$computername""_Processing_Details.txt"
arp -an 1>> $computername/LiveResponseData/NetworkInfo/ARP_table.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"


printf "Command Run: ifconfig -a\n"
printf "Command Run: ifconfig -a\n" >> "$computername/$computername""_Processing_Details.txt"
ifconfig -a 1>> $computername/LiveResponseData/NetworkInfo/Network_interface_info.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"


printf "Command Run: ifconfig -L\n"
printf "Command Run: ifconfig -L\n" >> "$computername/$computername""_Processing_Details.txt"
ifconfig -L 1>> $computername/LiveResponseData/NetworkInfo/Network_interface_info.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"


# Allowed hosts
if [ -f /etc/hosts.allow ]; then
	printf "Command Run: cat /etc/hosts.allow\n"
	printf "Command Run: cat /etc/hosts.allow\n" >> "$computername/$computername""_Processing_Details.txt"
	cat /etc/hosts.allow 1>> $computername/LiveResponseData/NetworkInfo/Hosts_allow.txt 2>> "$computername/$computername""_Processing_Details.txt"
	printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"
else
	printf "** File /etc/hosts.allow does not exist ***\n"
	printf "** File /etc/hosts.allow does not exist ***\n" >> "$computername/$computername""_Processing_Details.txt"
fi	

# Airport preferences file
if [ -f /Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist ]; then
	printf "** Reading file com.apple.airport.preferences.plist ***\n"
	printf "** Reading file com.apple.airport.preferences.plist ***\n" >> "$computername/$computername""_Processing_Details.txt"
	defaults read /Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist | sed 's:\./:$directorywherescriptrunsfrom/:g' | sed 's:.plist::g' | grep 'LastConnected' -A 9 1>> "$computername/LiveResponseData/NetworkInfo/Wifi_Access_Points.txt" 2>> "$computername/$computername""_Processing_Details.txt"
	printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"
else
	printf "** File /Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist does not exist ***\n"
	printf "** File /Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist does not exist ***\n" >> "$computername/$computername""_Processing_Details.txt"
fi	


# Firewall configuration
if [ -f /Library/Preferences/com.apple.alf.plist ]; then
	printf "Command Run: plutil -convert json /Library/Preferences/com.apple.alf.plist -o $computername/LiveResponseData/NetworkInfo/FirewallConfiguration_plist.txt\n"
	printf "Command Run: plutil -convert json /Library/Preferences/com.apple.alf.plist -o $computername/LiveResponseData/NetworkInfo/FirewallConfiguration_plist.txt\n" >> "$computername/$computername""_Processing_Details.txt"
	plutil -convert json /Library/Preferences/com.apple.alf.plist -o $computername/LiveResponseData/NetworkInfo/FirewallConfiguration_plist.txt 2>> "$computername/$computername""_Processing_Details.txt"
	printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"
else
	printf "** File /Library/Preferences/com.apple.alf.plist does not exist ***\n"
	printf "** File /Library/Preferences/com.apple.alf.plist does not exist ***\n" >> "$computername/$computername""_Processing_Details.txt"
fi	


# NAT configuration
if [ -f /Library/Preferences/SystemConfiguration/com.apple.nat.plist ]; then
	printf "Command Run: plutil -convert json /Library/Preferences/SystemConfiguration/com.apple.nat.plist -o $computername/LiveResponseData/NetworkInfo/NATConfiguration_plist.txt\n"
	printf "Command Run: plutil -convert json /Library/Preferences/SystemConfiguration/com.apple.nat.plist -o $computername/LiveResponseData/NetworkInfo/NATConfiguration_plist.txt\n" >> "$computername/$computername""_Processing_Details.txt"
	plutil -convert json /Library/Preferences/SystemConfiguration/com.apple.nat.plist -o $computername/LiveResponseData/NetworkInfo/NATConfiguration_plist.txt 2>> "$computername/$computername""_Processing_Details.txt"
	printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"
else
	printf "** File /Library/Preferences/SystemConfiguration/com.apple.nat.plist does not exist ***\n"
	printf "** File /Library/Preferences/SystemConfiguration/com.apple.nat.plist does not exist ***\n" >> "$computername/$computername""_Processing_Details.txt"
fi	


# SMB configuration
if [ -f /Library/Preferences/SystemConfiguration/com.apple.smb.server.plist ]; then
	printf "Command Run: plutil -convert json /Library/Preferences/SystemConfiguration/com.apple.smb.server.plist -o $computername/LiveResponseData/NetworkInfo/SMBConfiguration_plist.txt\n"
	printf "Command Run: plutil -convert json /Library/Preferences/SystemConfiguration/com.apple.smb.server.plist -o $computername/LiveResponseData/NetworkInfo/SMBConfiguration_plist.txt\n" >> "$computername/$computername""_Processing_Details.txt"
	plutil -convert json /Library/Preferences/SystemConfiguration/com.apple.smb.server.plist -o $computername/LiveResponseData/NetworkInfo/SMBConfiguration_plist.txt 2>> "$computername/$computername""_Processing_Details.txt"
	printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"
else
	printf "** File /Library/Preferences/SystemConfiguration/com.apple.smb.server.plist does not exist ***\n"
	printf "** File /Library/Preferences/SystemConfiguration/com.apple.smb.server.plist ***\n" >> "$computername/$computername""_Processing_Details.txt"
fi


echo ""
echo "** Completed running $modulename module **"
echo ""
return