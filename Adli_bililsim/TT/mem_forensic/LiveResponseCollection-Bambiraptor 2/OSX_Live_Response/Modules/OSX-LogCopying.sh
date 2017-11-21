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
#Making directories
printf "Command Run: mkdir -p $computername/LiveResponseData/CopiedFiles/Logs\n"
printf "Command Run: mkdir -p $computername/LiveResponseData/CopiedFiles/Logs\n" >> "$computername/$computername""_Processing_Details.txt"
mkdir -p $computername/LiveResponseData/CopiedFiles/Logs >> "$computername/$computername""_Processing_Details.txt" 2>&1
printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

printf "Command Run: mkdir -p $computername/LiveResponseData/CopiedFiles/Logs/var\n"
printf "Command Run: mkdir -p $computername/LiveResponseData/CopiedFiles/Logs/var\n" >> "$computername/$computername""_Processing_Details.txt"
mkdir -p $computername/LiveResponseData/CopiedFiles/Logs/var >> "$computername/$computername""_Processing_Details.txt" 2>&1
printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

printf "Command Run: mkdir -p $computername/LiveResponseData/CopiedFiles/Logs/private/var\n"
printf "Command Run: mkdir -p $computername/LiveResponseData/CopiedFiles/Logs/private/var\n" >> "$computername/$computername""_Processing_Details.txt"
mkdir -p $computername/LiveResponseData/CopiedFiles/Logs/private/var >> "$computername/$computername""_Processing_Details.txt" 2>&1
printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

#Copying logs
printf "Command Run: cp /var/log/*.log* $computername/LiveResponseData/CopiedFiles/Logs/var\n"
printf "Command Run: cp /var/log/*.log* $computername/LiveResponseData/CopiedFiles/Logs/var\n" >> "$computername/$computername""_Processing_Details.txt"
cp /var/log/*.log* $computername/LiveResponseData/CopiedFiles/Logs/var 2>&1 >> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

printf "Command Run: cp /private/var/log/*.log* $computername/LiveResponseData/CopiedFiles/Logs/private/var\n"
printf "Command Run: cp /private/var/log/*.log* $computername/LiveResponseData/CopiedFiles/Logs/private/var\n" >> "$computername/$computername""_Processing_Details.txt"
cp /private/var/log/*.log* $computername/LiveResponseData/CopiedFiles/Logs/private/var 2>&1 >> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

echo ""
echo "***** Completed running $modulename module *****"
echo ""
return