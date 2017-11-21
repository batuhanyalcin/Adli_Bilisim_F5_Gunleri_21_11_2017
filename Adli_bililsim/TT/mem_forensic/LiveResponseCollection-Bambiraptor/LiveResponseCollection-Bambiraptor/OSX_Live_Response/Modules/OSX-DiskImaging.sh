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


 	#Capturing Disk Image of target system 
 	printf "df -Pl\n" >> "$computername/$computername""_Processing_Details.txt"
	df -Pl >> $computername/LiveResponseData/BasicInfo/MappedDrives.txt
	printf "\n\n" >> "$computername/$computername""_Processing_Details.txt"
	for line in $(<$computername/LiveResponseData/BasicInfo/MappedDrives.txt)
	do	
		if [[ ! "$line" =~ "Avail" ]] && [[ ! "$line" =~ "$trimsp" ]]; then
			drivemountpoint=$(echo $line | awk '{printf "%s",$1}') #Getting the mount point
			totaldrivesize=$(echo $line | awk '{printf "%s",$2}') #Getting free space
			realtds=$(( $totaldrivesize * 512))
			# This will update the destination drive space each time, to ensure we have the free space needed to do it
			updatedextdrivefreespace=$(df -Pl $trimsp| sed -e /Available/d | awk '{printf "%s",$4}' )
			realupdatedextdrivefreespace=$(( $updatedextdrivefreespace * 512))
			drivename=$(echo $drivemountpoint | sed 's:/dev/::')
			#Since the disk drive is busy and in use during live acquisition, we must use corresponding "raw" disk to capture the image
			raw="/dev/r"
			rawname=($raw$drivename)
			echo "Raw Disk is $rawname" >> $computername/LiveResponseData/BasicInfo/MappedDrives.txt
			diskutil enableOwnership $rawname
			echo ""
			echo "Drive to image mount point is $drivemountpoint"
			printf "Drive to image mount point is $drivemountpoint\n" >> "$computername/$computername""_Processing_Details.txt"
			echo "Drive to image size is $realtds\n"
			printf "Drive to image size is $realtds\n" >> "$computername/$computername""_Processing_Details.txt"
			#Check to make sure there is enough free space for the disk image
			if [ "$realtds" -lt "$realupdatedextdrivefreespace" ]; then
				echo "Target drive is $realtds bytes in size"
				echo "Destination has $realupdatedextdrivefreespace bytes free"
				echo "We passed the size imaging checks! Disk imaging will begin"
				echo
				echo "Please be patient, this may take some time"
				echo
				# sudo dd if=$rawname | $directorywherescriptrunsfrom/Tools/ftkimager/ftkimager - "$computername/ForensicImages/DiskImage/$computername""_$drivename" --e01 --frag 4096M --compress 4 --verify
				sudo dd if=$rawname bs=4k conv=sync,noerror | tee "$computername/ForensicImages/DiskImage/$computername""_$drivename.dd" | md5 > "$computername/ForensicImages/DiskImage/$computername""_$drivename-md5_hash.txt"
				echo
				echo "Disk imaging is complete. Please check the Image Summary text file for verification."
				printf "\nDisk imaging is complete. Please check the Image Summary text file for verification." >> "$computername/$computername""_Processing_Details.txt"
			else 
				echo "Target drive is $realtds bytes in size and the extenal drive has $realupdatedextdrivefreespace of available free space. This is not enough free space to a forensic disk image."
				printf "\nNot enough free space on external drive to create a forensic disk image." >> "$computername/$computername""_Processing_Details.txt"
			fi
		fi
	done

elif [[ ! "$directorywherescriptrunsfrom" =~ "Volumes" ]]; then
	echo "This script is running from the Target host. We caution you to not run this script for the host."
	echo "***** Please run from an externally connected drive to collect memory and disk image *****"
	printf "***** Please run from an externally connected drive to collect memory and disk image *****" >> "$computername/$computername""_Processing_Details.txt"
	done
fi  




echo ""
echo "***** Completed running $modulename module *****"
printf "***** Completed running $modulename module *****\n" >> "$computername/$computername""_Processing_Details.txt"
echo ""
return