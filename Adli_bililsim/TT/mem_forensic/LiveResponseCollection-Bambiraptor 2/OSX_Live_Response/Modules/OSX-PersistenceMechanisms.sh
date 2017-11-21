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


printf "Command Run: ls -laR /System/Library/StartupItems | grep -v ^d\n"
printf "Command Run: ls -laR /System/Library/StartupItems | grep -v ^d\n" >> "$computername/$computername""_Processing_Details.txt"
ls -laR /System/Library/StartupItems | grep -v ^d 1>> $computername/LiveResponseData/PersistenceMechanisms/System_Startup_Items.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"


printf "Command Run: ls -al /System/Library/LaunchAgents | grep -v ^d\n"
printf "Command Run: ls -al /System/Library/LaunchAgents | grep -v ^d\n" >> "$computername/$computername""_Processing_Details.txt"
ls -laR /System/Library/StartupItems | grep -v ^d 1>> $computername/LiveResponseData/PersistenceMechanisms/System_Startup_Items.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

printf "Command Run: ls -al /System/Library/LaunchDaemons | grep -v ^d\n"
printf "Command Run: ls -al /System/Library/LaunchDaemons | grep -v ^d\n" >> "$computername/$computername""_Processing_Details.txt"
ls -al /System/Library/LaunchDaemons | grep -v ^d 1>> $computername/LiveResponseData/PersistenceMechanisms/System_Launch_Daemons.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

printf "Command Run: ls -al /Library/LaunchAgents | grep -v ^d\n"
printf "Command Run: ls -al /Library/LaunchAgents | grep -v ^d\n" >> "$computername/$computername""_Processing_Details.txt"
ls -al /Library/LaunchAgents | grep -v ^d 1>> $computername/LiveResponseData/PersistenceMechanisms/Library_Launch_Agents.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

printf "Command Run: ls -al /Library/LaunchDaemons | grep -v ^d\n"
printf "Command Run: ls -al /Library/LaunchDaemons | grep -v ^d\n" >> "$computername/$computername""_Processing_Details.txt"
ls -al /Library/LaunchDaemons | grep -v ^d 1>> $computername/LiveResponseData/PersistenceMechanisms/Library_Launch_Daemons.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

printf "Command Run: ls -al /Library/StartupItems | grep -v ^d\n"
printf "Command Run: ls -al /Library/StartupItems | grep -v ^d\n" >> "$computername/$computername""_Processing_Details.txt"
ls -al /Library/StartupItems | grep -v ^d 1>> $computername/LiveResponseData/PersistenceMechanisms/Library_Startup_Items.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

printf "Command Run: find /Applications/ -name LogInItems -exec ls -lsct {} \\;\n" 
printf "Command Run: find /Applications/ -name LogInItems -exec ls -lsct {} \\;\n" >> "$computername/$computername""_Processing_Details.txt"
find /Applications/ -name LogInItems -exec ls -lsct {} \; 1>> $computername/LiveResponseData/PersistenceMechanisms/Applications_LogInItems.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"


echo ""
echo "** Completed running $modulename module **"
echo ""
return