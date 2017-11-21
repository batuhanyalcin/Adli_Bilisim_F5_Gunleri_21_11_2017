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

printf "Command Run: cat /etc/passwd\n"
printf "Command Run: cat /etc/passwd\n" >> "$computername/$computername""_Processing_Details.txt"
cat /etc/passwd 1>> $computername/LiveResponseData/UserInfo/passwd.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

printf "Command Run: cat /etc/group\n"
printf "Command Run: cat /etc/group\n" >> "$computername/$computername""_Processing_Details.txt"
cat /etc/group 1>> $computername/LiveResponseData/UserInfo/group.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

for i in `ls /Users/`
do 

	# bash history
	if [ -e /Users/$i/.bash_history ]; then
		printf "Command Run: cat /Users/$i/.bash_history\n"
		printf "Command Run: cat /Users/$i/.bash_history\n" >> "$computername/$computername""_Processing_Details.txt"
		cat /Users/$i/.bash_history 1>> $computername/LiveResponseData/UserInfo/User-$i-bash_History.txt 2>> "$computername/$computername""_Processing_Details.txt"
		printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"
	else
		printf "** File /Users/$i/.bash_history does not exist ***\n"
		printf "** File /Users/$i/.bash_history does not exist ***\n" >> "$computername/$computername""_Processing_Details.txt"
	fi

	# sh history
	if [ -e /Users/$i/.sh_history ]; then
		printf "Command Run: cat /Users/$i/.sh_history\n"	
		printf "Command Run: cat /Users/$i/.sh_history\n" >> "$computername/$computername""_Processing_Details.txt"
		cat /Users/$i/.sh_history 1>> $computername/LiveResponseData/UserInfo/User-$i-sh_History.txt 2>> "$computername/$computername""_Processing_Details.txt"
		printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"
	else
		printf "** File /Users/$i/.sh_history does not exist ***\n"
		printf "** File /Users/$i/.sh_history does not exist ***\n" >> "$computername/$computername""_Processing_Details.txt"
	fi


	# Launch Agents
	if [ -d /Users/$i/Library/LaunchAgents/ ]; then
		printf "Command Run: ls -al /Users/$i/Library/LaunchAgents/ | grep -v ^d\n"	
		printf "Command Run: ls -al /Users/$i/Library/LaunchAgents/ | grep -v ^d\n" >> "$computername/$computername""_Processing_Details.txt"
		ls -al /Users/$i/Library/LaunchAgents/ | grep -v ^d 1>> $computername/LiveResponseData/PersistenceMechanisms/User-$i-LaunchAgents.txt 2>> "$computername/$computername""_Processing_Details.txt"
		printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"
	else
		printf "** Directory /Users/$i/Library/LaunchAgents/ does not exist ***\n"
		printf "** Directory /Users/$i/Library/LaunchAgents/ does not exist ***\n" >> "$computername/$computername""_Processing_Details.txt"
	fi


	# Login Window
	if [ -f /Users/$i/Library/Preferences/loginwindow.plist ]; then
		printf "Command Run: plutil -convert json /Users/$i/Library/Preferences/loginwindow.plist -o $computername/LiveResponseData/PersistenceMechanisms/User-$i-loginwindow_plist.txt\n"	
		printf "Command Run: plutil -convert json /Users/$i/Library/Preferences/loginwindow.plist -o $computername/LiveResponseData/PersistenceMechanisms/User-$i-loginwindow_plist.txt\n" >> "$computername/$computername""_Processing_Details.txt"
		plutil -convert json /Users/$i/Library/Preferences/loginwindow.plist -o $computername/LiveResponseData/PersistenceMechanisms/User-$i-loginwindow_plist.txt 2>> "$computername/$computername""_Processing_Details.txt"
		printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"
	else
		printf "** File /Users/$i/Library/Preferences/loginwindow.plist does not exist ***\n"
		printf "** File /Users/$i/Library/Preferences/loginwindow.plist does not exist ***\n" >> "$computername/$computername""_Processing_Details.txt"
	fi	


	# AddressBook Me
	if [ -f /Users/$i/Library/Preferences/AddressBookMe.plist ]; then
		printf "Command Run: plutil -convert json /Users/$i/Library/Preferences/AddressBookMe.plist -o $computername/LiveResponseData/UserInfo/User-$i-AddressBookMe_plist.txt\n"	
		printf "Command Run: plutil -convert json /Users/$i/Library/Preferences/AddressBookMe.plist -o $computername/LiveResponseData/UserInfo/User-$i-AddressBookMe_plist.txt\n" >> "$computername/$computername""_Processing_Details.txt"
		plutil -convert json /Users/$i/Library/Preferences/AddressBookMe.plist -o $computername/LiveResponseData/UserInfo/User-$i-AddressBookMe.plist_txt 2>> "$computername/$computername""_Processing_Details.txt"
		printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"
	else
		printf "** File /Users/$i/Library/Preferences/AddressBookMe.plist does not exist ***\n"
		printf "** File /Users/$i/Library/Preferences/AddressBookMe.plist does not exist ***\n" >> "$computername/$computername""_Processing_Details.txt"
	fi	

	# AddressBook (newer versions of OSX)
	if [ -f /Users/$i/Library/Preferences/com.apple.AddressBook.plist ]; then
		printf "Command Run: plutil -convert json /Users/$i/Library/Preferences/com.apple.AddressBook.plist -o $computername/LiveResponseData/UserInfo/User-$i-AddressBook_plist.txt\n"	
		printf "Command Run: plutil -convert json /Users/$i/Library/Preferences/com.apple.AddressBook.plist -o $computername/LiveResponseData/UserInfo/User-$i-AddressBook_plist.txt\n" >> "$computername/$computername""_Processing_Details.txt"
		plutil -convert json /Users/$i/Library/Preferences/com.apple.AddressBook.plist -o $computername/LiveResponseData/UserInfo/User-$i-AddressBook_plist.txt 2>> "$computername/$computername""_Processing_Details.txt"
		printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"
	else
		printf "** File /Users/$i/Library/Preferences/AddressBook.plist does not exist ***\n"
		printf "** File /Users/$i/Library/Preferences/AddressBook.plist does not exist ***\n" >> "$computername/$computername""_Processing_Details.txt"
	fi	

	# Login Items
	if [ -f /Users/$i/Library/Preferences/com.apple.loginitems.plist ]; then
		printf "Command Run: plutil -convert json /Users/$i/Library/Preferences/com.apple.loginitems.plist -o $computername/LiveResponseData/PersistenceMechanisms/User-$i-LaunchedLogInItems_plist.txt\n"	
		printf "Command Run: plutil -convert json /Users/$i/Library/Preferences/com.apple.loginitems.plist -o $computername/LiveResponseData/PersistenceMechanisms/User-$i-LaunchedLogInItems_plist.txt\n" >> "$computername/$computername""_Processing_Details.txt"
		plutil -convert json /Users/$i/Library/Preferences/com.apple.loginitems.plist -o $computername/LiveResponseData/PersistenceMechanisms/User-$i-LaunchedLogInItems_plist.txt 2>> "$computername/$computername""_Processing_Details.txt"
		printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"
	else
		printf "** File /Users/$i/Library/Preferences/com.apple.loginitems.plist does not exist ***\n"
		printf "** File /Users/$i/Library/Preferences/com.apple.loginitems.plist does not exist ***\n" >> "$computername/$computername""_Processing_Details.txt"
	fi	

	# Recent Items
	if [ -f /Users/$i/Library/Preferences/com.apple.recentitems.plist ]; then
		printf "Command Run: plutil -convert json /Users/$i/Library/Preferences/com.apple.recentitems.plist -o $computername/LiveResponseData/UserInfo/User-$i-RecentItems_plist.txt\n"	
		printf "Command Run: plutil -convert json /Users/$i/Library/Preferences/com.apple.recentitems.plist -o $computername/LiveResponseData/UserInfo/User-$i-RecentItems_plist.txt\n" >> "$computername/$computername""_Processing_Details.txt"
		plutil -convert json /Users/$i/Library/Preferences/com.apple.recentitems.plist -o $computername/LiveResponseData/UserInfo/User-$i-RecentItems_plist.txt 2>> "$computername/$computername""_Processing_Details.txt"
		printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"
	else
		printf "** File /Users/$i/Library/Preferences/com.apple.recentitems.plist does not exist ***\n"
		printf "** File /Users/$i/Library/Preferences/com.apple.recentitems.plist does not exist ***\n" >> "$computername/$computername""_Processing_Details.txt"
	fi	



done

echo ""
echo "** Completed running $modulename module **"
echo ""
return