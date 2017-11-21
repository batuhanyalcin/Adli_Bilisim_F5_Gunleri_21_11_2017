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


#INITIAL HOUSEKEEPING 
ScriptStart=$(date +%s)
lrcbuildname="Live Response Collection (Bambiraptor Build - 20161212)"
scriptname=`basename "$0"`
directorywherescriptrunsfrom=$(pwd) #Getting directory from where the script is running
modulepath="$directorywherescriptrunsfrom/Modules/"
runningfromexternal="no"
cname=$(hostname -s)
ts=$(date +%Y%m%d_%H%M%S)
computername=$cname\_$ts
mkdir -p $computername
printf "***** All commands run and (if applicable) any error messages *****\n" >> "$computername/$computername""_Processing_Details.txt"
printf "OS Type: OSX\n" >> "$computername/$computername""_Processing_Details.txt"
printf "Computername: $cname\n" >> "$computername/$computername""_Processing_Details.txt"
printf "Time stamp: $ts\n" >> "$computername/$computername""_Processing_Details.txt"
printf "Live Response Collection version: $lrcbuildname\n" >> "$computername/$computername""_Processing_Details.txt"
printf "Live Response Collection script run: $scriptname\n\n" >> "$computername/$computername""_Processing_Details.txt"
printf "mkdir -p $computername\n" >> "$computername/$computername""_Processing_Details.txt"

#DIRECTORY CREATION MODULE
#Running directory creation module
echo ""
echo "***** Beginning OSX Directory Creation module *****"
source "$directorywherescriptrunsfrom/Modules/OSX-DirectoryCreation.sh"
echo "***** Ending OSX Directory Creation module *****"
echo ""

#Checking for administrator privileges. We need this for the memory dump and disk imaging
if [[ $EUID -ne 0 ]]; then
	echo "You do not have root permissions. Skipping memory dump and FSEvents copying"
	printf "You do not have root permissions. Skipping memory dump and FSEvents copying\n" >> "$computername/$computername""_Processing_Details.txt"
else
	#Running FSEventsd copying module
	echo ""
	echo "***** Beginning OSX FSEventsd module *****"
	source "$directorywherescriptrunsfrom/Modules/OSX-fseventsdCopying.sh"
	echo "***** Ending OSX FSEventsd module *****"
	echo ""
fi


#HIDDEN FILES - May eventually put something in here

#LOG COPYING
#Running log copying module
echo ""
echo "***** Beginning OSX log copying module *****"
source "$directorywherescriptrunsfrom/Modules/OSX-LogCopying.sh"
echo "***** Ending OSX log copying module *****"
echo ""

#BASIC INFORMATION
#Running basic information module
echo ""
echo "***** Beginning OSX basic information module *****"
source "$directorywherescriptrunsfrom/Modules/OSX-BasicInfo.sh"
echo "***** Ending OSX basic information module *****"
echo ""


#USER INFORMATION
#Running user information module
echo ""
echo "***** Beginning OSX user information module *****"
source "$directorywherescriptrunsfrom/Modules/OSX-UserInfo.sh"
echo "***** Ending OSX user information module *****"
echo ""


#PERSISTENCE MECHANISMS
#Running persistence mechanisms module
echo ""
echo "***** Beginning OSX persistence mechanism module *****"
source "$directorywherescriptrunsfrom/Modules/OSX-PersistenceMechanisms.sh"
echo "***** Ending OSX persistence mechanism module *****"
echo ""


#NETWORK INFO
#Running persistence mechanisms module
echo ""
echo "***** Beginning OSX network information module *****"
source "$directorywherescriptrunsfrom/Modules/OSX-NetworkInfo.sh"
echo "***** Ending OSX network information module *****"
echo ""


#PROCESSING DETAILS AND HASHES
#Running hashing module
echo ""
echo "***** Beginning OSX LRC hashing module *****"
source "$directorywherescriptrunsfrom/Modules/OSX-LRCHashing.sh"
echo "***** Ending OSX LRC hashing module *****"
echo ""


#Finishing up
echo Congratulations\! The BriMor Labs OSX Live Response Collection is now complete.
ScriptEnd=$(date +%s)
ScriptRunTime=$(expr $ScriptEnd - $ScriptStart)
if (("$ScriptRunTime" < 60)); then
	printf "The script took a total of $ScriptRunTime seconds to run\n"
	printf "\n...Exiting script now.\nEnd Of Line.\n\n"
else
	Minutes=$(expr $ScriptRunTime / 60)
	Seconds=$(expr $ScriptRunTime % 60)
	printf "The script took a total of $Minutes minutes and $Seconds seconds to run\n"
	printf "\n...Exiting script now.\nEnd Of Line.\n\n"
fi
	
exit

#LIST_OF_ALL_UPDATES
# Live Response Collection (Bambiraptor Build - 20161212) - Added automated disk imaging using dd. Added Complete, Memory Dump, and Triage options. Fixed small typos
# Live Response Collection (Allosaurus Build - 20160112) - Added memory dump extraction, added modules (similar to Windows Live Response Collection). Added logging file. Many changes to resemble the Windows Live Response Collection. Added change to volume mapping and free size computation to work with external drives attached with the same name and account for spaces in drive name (Thanks @CdtDelta)!
#Version 1.4 Due to a coding oversight, I forgot to put "LiveResponseData" in the file path. Thanks very much to Cristina Roura for pointing that out!
#Version 1.3 Added automated MD5 and SHA256 file hashing of all output files, saved as "Processing_Details_and_Hashes.txt"