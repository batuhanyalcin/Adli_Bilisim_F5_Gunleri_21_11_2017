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
printf "***** Now running $modulename module *****\n" >> "$computername/$computername""_Processing_Details.txt"


#Determine size of memory
printf "Command Run: memorysize=$(sysctl -a | grep memsize | awk '{printf "%s",$2}')\n" >> "$computername/$computername""_Processing_Details.txt"
memorysize=$(sysctl -a | grep memsize | awk '{printf "%s",$2}') >> "$computername/$computername""_Processing_Details.txt" 2>&1
memorysize=${memorysize//[!0-9]/}	
printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

printf "Command Run: sysctl -a | grep memsize >> $computername/LiveResponseData/BasicInfo/TotalSizeOfMemory.txt\n"  >> "$computername/$computername""_Processing_Details.txt"
sysctl -a | grep memsize 1>> $computername/LiveResponseData/BasicInfo/TotalSizeOfMemory.txt 2>> "$computername/$computername""_Processing_Details.txt"
printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

echo "Total size of installed memory is $memorysize"
printf "Total size of installed memory is $memorysize\n" >> "$computername/$computername""_Processing_Details.txt"

#This will be required if we do disk imaging in the future. For now, it is not a requirement
if [[ "$directorywherescriptrunsfrom" =~ "Volumes" ]]; then
	runningfromexternal="yes" #Congratulations! It is running externally!
	shortpath=$(egrep -oh "/Volumes/.*?/" <<< $directorywherescriptrunsfrom) #Getting just the partial path. This is used for free space and suches
	trimsp=$(echo $shortpath | sed 's:/*$::') #Trimming trailing slash
	printf "Command Run: df \"$trimsp\"\n" >> "$computername/$computername""_Processing_Details.txt"
	df "$trimsp" | sed 's/\(.*\)/\1/' 1>> $computername/LiveResponseData/BasicInfo/ScriptLocationData.txt 2>> "$computername/$computername""_Processing_Details.txt"
	printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"
	printf "Command Run: mappeddrive=$(df -Pl | awk '{printf "%s %s %s %s\n",$1,$2,$4,$6}')\n" >> "$computername/$computername""_Processing_Details.txt"	
	mappeddrive=$(df "$trimsp" | sed 's/\(.*\)/\1/')
	printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"
	IFS=$'\n'
	for line in $(<$computername/LiveResponseData/BasicInfo/ScriptLocationData.txt)
	do
		if [[ "$line" =~ "$trimsp" ]]; then
			filesystemmountpoint=$(echo $line | awk '{printf "%s",$1}') #Getting the mount point
			externaldrivefreespace=$(echo $line | awk '{printf "%s",$4}') #Getting free space
			externaldrivefreespace=${externaldrivefreespace//[!0-9]/}
			realedfs=$(( $externaldrivefreespace * 512))
			realedfs=${realedfs//[!0-9]/}
			echo "Ext drive mount point $filesystemmountpoint"
			echo "Ext drive free space $realedfs"
			printf "\nExt drive mount point $filesystemmountpoint\nExt drive free space $realedfs\n" >> "$computername/$computername""_Processing_Details.txt"
			#Ensuring memorysize is less than free space on disk
			if [ "$memorysize" -lt "$realedfs" ]; then
				
				#Changing ownership of external disk for current user so we can automate memory dump
				printf "Command Run: diskutil enableOwnership $filesystemmountpoint\n" >> "$computername/$computername""_Processing_Details.txt"
				diskutil enableOwnership $filesystemmountpoint
				printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"
				
				#Other memory dump stuff
				printf "Command Run: unzip $directorywherescriptrunsfrom/Tools/osxpmem_2.1/osxpmem_2.1.zip -d $directorywherescriptrunsfrom/Tools/osxpmem_2.1/temp\n" >> "$computername/$computername""_Processing_Details.txt"
				unzip $directorywherescriptrunsfrom/Tools/osxpmem_2.1/osxpmem_2.1.zip -d $directorywherescriptrunsfrom/Tools/osxpmem_2.1/temp
				printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

				printf "Command Run: chown -R 0:0 $directorywherescriptrunsfrom/Tools/osxpmem_2.1/temp/osxpmem.app/MacPmem.kext\n" >> "$computername/$computername""_Processing_Details.txt"
				chown -R 0:0 $directorywherescriptrunsfrom/Tools/osxpmem_2.1/temp/osxpmem.app/MacPmem.kext
				printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

				printf "Command Run: kextload $directorywherescriptrunsfrom/Tools/osxpmem_2.1/temp/osxpmem.app/MacPmem.kext\n" >> "$computername/$computername""_Processing_Details.txt"				
				kextload $directorywherescriptrunsfrom/Tools/osxpmem_2.1/temp/osxpmem.app/MacPmem.kext
				printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"
								
				printf "Command Run: $directorywherescriptrunsfrom/Tools/osxpmem_2.1/temp/osxpmem.app/osxpmem -p -m -t -c snappy -o ""$computername/ForensicImages/Memory/$computername""_memory.aff4\n" >> "$computername/$computername""_Processing_Details.txt"
				$directorywherescriptrunsfrom/Tools/osxpmem_2.1/temp/osxpmem.app/osxpmem -p -m -t -c snappy -o ""$computername/ForensicImages/Memory/$computername""_memory.aff4""
				md5 "$computername/ForensicImages/Memory/$computername""_memory.aff4" >> "$computername/ForensicImages/Memory/$computername""_memory_dmp_hashes.txt"
				shasum -a 256 "$computername/ForensicImages/Memory/$computername""_memory.aff4" >> "$computername/ForensicImages/Memory/$computername""_memory_dmp_hashes.txt"
				printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

				printf "Command Run: kextunload $directorywherescriptrunsfrom/Tools/osxpmem_2.1/temp/osxpmem.app/MacPmem.kext\n" >> "$computername/$computername""_Processing_Details.txt"				
				kextunload $directorywherescriptrunsfrom/Tools/osxpmem_2.1/temp/osxpmem.app/MacPmem.kext
				printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

				printf "Command Run: rm -rf \"$directorywherescriptrunsfrom/Tools/osxpmem_2.1/temp\"*\n" >> "$computername/$computername""_Processing_Details.txt"
				rm -rf "$directorywherescriptrunsfrom/Tools/osxpmem_2.1/temp"*
				printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

			fi
		fi
	done
	
elif [[ ! "$directorywherescriptrunsfrom" =~ "Volumes" ]]; then
	printf "df -Pl\n" >> "$computername/$computername""_Processing_Details.txt"
	df -Pl >> $computername/LiveResponseData/BasicInfo/MappedDrives.txt
	printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

	IFS=$'\n'
	realedfs=$(diskutil info / | grep "Free Space" | awk '{printf "%s\n",$6}' | sed 's:(::')
	realedfs=${realedfs//[!0-9]/}	
	printf "Total size of disk free space is $realedfs\n"
	printf "Total size of disk free space is $realedfs\n" >> "$computername/$computername""_Processing_Details.txt"
	#Ensuring memorysize is less than free space on disk
	if [ "$memorysize" -lt "$realedfs" ]; then
		#Other memory dump stuff
		printf "unzip $directorywherescriptrunsfrom/Tools/osxpmem_2.1/osxpmem_2.1.zip -d $directorywherescriptrunsfrom/Tools/osxpmem_2.1/temp\n" >> "$computername/$computername""_Processing_Details.txt"
		unzip $directorywherescriptrunsfrom/Tools/osxpmem_2.1/osxpmem_2.1.zip -d $directorywherescriptrunsfrom/Tools/osxpmem_2.1/temp
		printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

		printf "chown -R 0:0 $directorywherescriptrunsfrom/Tools/osxpmem_2.1/temp/osxpmem.app/MacPmem.kext\n" >> "$computername/$computername""_Processing_Details.txt"
		chown -R 0:0 $directorywherescriptrunsfrom/Tools/osxpmem_2.1/temp/osxpmem.app/MacPmem.kext
		printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"
	
		printf "kextload $directorywherescriptrunsfrom/Tools/osxpmem_2.1/temp/osxpmem.app/MacPmem.kext\n" >> "$computername/$computername""_Processing_Details.txt"	
		kextload $directorywherescriptrunsfrom/Tools/osxpmem_2.1/temp/osxpmem.app/MacPmem.kext
		printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

		printf "$directorywherescriptrunsfrom/Tools/osxpmem_2.1/temp/osxpmem.app/osxpmem --elf -o ""$computername/ForensicImages/Memory/$computername""_memory.dmp\n" >> "$computername/$computername""_Processing_Details.txt"		
		$directorywherescriptrunsfrom/Tools/osxpmem_2.1/temp/osxpmem.app/osxpmem --elf -o "$computername/ForensicImages/Memory/$computername""_memory.dmp"
		md5 "$computername/ForensicImages/Memory/$computername""_memory.dmp" >> "$computername/ForensicImages/Memory/$computername""_memory_dmp_hashes.txt"
		shasum -a 256 "$computername/ForensicImages/Memory/$computername""_memory.dmp" >> "$computername/ForensicImages/Memory/$computername""_memory_dmp_hashes.txt"		
		printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

		printf "kextunload $directorywherescriptrunsfrom/Tools/osxpmem_2.1/temp/osxpmem.app/MacPmem.kext\n" >> "$computername/$computername""_Processing_Details.txt"
		kextunload $directorywherescriptrunsfrom/Tools/osxpmem_2.1/temp/osxpmem.app/MacPmem.kext
		printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

		printf "rm -rf \"$directorywherescriptrunsfrom/Tools/osxpmem_2.1/temp\"*\n" >> "$computername/$computername""_Processing_Details.txt"
		rm -rf "$directorywherescriptrunsfrom/Tools/osxpmem_2.1/temp"*
		printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

	fi

else
	printf "Automated memory dump cannot be completed due to an unknown reason\n"
	printf "Automated memory dump cannot be completed due to an unknown reason\n" >> "$computername/$computername""_Processing_Details.txt"
	printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"

fi

echo ""
echo "***** Completed running $modulename module *****"
printf "***** Completed running $modulename module *****\n" >> "$computername/$computername""_Processing_Details.txt"
echo ""
return