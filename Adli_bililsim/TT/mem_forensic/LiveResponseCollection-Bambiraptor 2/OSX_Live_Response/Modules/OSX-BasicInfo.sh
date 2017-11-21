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
echo "***** Now running $modulename module *****"

printf "Command Run: pwd\n"
printf "Command Run: pwd\n" 1>> "$computername/$computername""_Processing_Details.txt"
pwd 1>> $computername/LiveResponseData/BasicInfo/DirectoryLRClaunchedfrom.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" 1>> "$computername/$computername""_Processing_Details.txt"

printf "Command Run: df -Hl\n"
printf "Command Run: df -Hl\n" 1>> "$computername/$computername""_Processing_Details.txt"
df -Hl 1>> $computername/LiveResponseData/BasicInfo/AllMountedDisks.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" 1>> "$computername/$computername""_Processing_Details.txt"

printf "Command Run: date\n"
printf "Command Run: date\n" 1>> "$computername/$computername""_Processing_Details.txt"
date 1>> $computername/LiveResponseData/BasicInfo/date.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" 1>> "$computername/$computername""_Processing_Details.txt"

printf "Command Run: hostname\n"
printf "Command Run: hostname\n" 1>> "$computername/$computername""_Processing_Details.txt"
hostname 1>> $computername/LiveResponseData/BasicInfo/hostname.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" 1>> "$computername/$computername""_Processing_Details.txt"

printf "Command Run: who\n"
printf "Command Run: who\n" 1>> "$computername/$computername""_Processing_Details.txt"
who 1>> $computername/LiveResponseData/BasicInfo/Logged_In_Users.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" 1>> "$computername/$computername""_Processing_Details.txt"

printf "Command Run: ps auxwww\n"
printf "Command Run: ps auxwww\n" 1>> "$computername/$computername""_Processing_Details.txt"
ps auxwww 1>> $computername/LiveResponseData/BasicInfo/List_of_Running_Processes.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" 1>> "$computername/$computername""_Processing_Details.txt"

printf "Command Run: mount\n"
printf "Command Run: mount\n" 1>> "$computername/$computername""_Processing_Details.txt"
mount 1>> $computername/LiveResponseData/BasicInfo/Mounted_items.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" 1>> "$computername/$computername""_Processing_Details.txt"

printf "Command Run: diskutil\n"
printf "Command Run: diskutil\n" 1>> "$computername/$computername""_Processing_Details.txt"
diskutil list 1>> $computername/LiveResponseData/BasicInfo/Disk_utility.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" 1>> "$computername/$computername""_Processing_Details.txt"

printf "Command Run: kextstat -l\n"
printf "Command Run: kextstat -l\n" 1>> "$computername/$computername""_Processing_Details.txt"
kextstat -l 1>> $computername/LiveResponseData/BasicInfo/Loaded_Kernel_Extensions.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" 1>> "$computername/$computername""_Processing_Details.txt"


echo ""
echo "***** Completed running $modulename module *****"
echo ""
return