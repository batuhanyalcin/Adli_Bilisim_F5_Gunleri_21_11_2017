NAME_VERSION: Live Response Collection (Bambiraptor Build - 20161212)
RELEASE DATE: 20161212
AUTHOR: Brian Moran (brian@brimorlabs.com)
TWITTER: BriMor Labs (@BriMorLabs)
Copyright: 2013-2016, Brian Moran

This file is part of the BriMor Labs Live Response Collection

The Live Response Collection is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

Additionally, usages of all tools fall under the express license agreement stated by the tool itself.



THE INFORMING INFORMATION SECTION:
This is meant to be a collection of tools used to gather and triage data from a live OSX system.

Running the script of your choice, "Complete_OSX_Live_Response.sh", "Memory_Dump_OSX_Live_Response.sh", or "Triage_OSX_Live_Response.sh" from a terminal window will allow the script to collect data from live system running an OSX operating system. If run with admininstrator privileges (sudo) it will collect more information. Administrator privileges are required if you want to automate the creation of a disk image and/or memory dump.




AUTHOR NOTE: I would like to extend a very special "Thank you" to Mari DeGrazia (@maridegrazia), Adrian Leong (@Cheeky4n6Monkey), Ken Pryor (@KDPryor), Josh Madeley (@MadeleyJosh), Roberta Payne (@robertapayne_1), Brad Garnett (@brgarnett), Luca Pugliese (@lupug), Alexis Wells, Kevin Pagano (@KevinPagano3), Mark McKinnon (@markmckinnon), Tom Yarrish (@CdtDelta), Cristina Roura, Mitch Impey (@grumpy4n6), Jonathon Poling (@jpoforenso), and Darcy Adefehinti (@regaindata) for their extensive testing and valuable feedback to make this tool what it is today!




-----CHANGES-----
20161212 - Bambiraptor Build public release
20161030 - Bambiraptor Build out for beta testing
20160112 - Allosaurus Build released
20160108 - Added fseventsd collection
20151224 - Added output parsing to try to eliminate non numeric characters in command output since OSX follows no standards with regards to data output
20151109 - Added memory dump extraction, added modules (similar to Windows Live Response Collection). Added logging file. Many changes to resemble the Windows Live Response Collection. Added change to volume mapping and free size computation to work with external drives attached with the same name and account for spaces in drive name (Thanks @CdtDelta)!
20150320 - Due to a coding oversight, I forgot to put "LiveResponseData" in the file path. Thanks very much to Cristina Roura for pointing that out!

20150319 - Added automated MD5 and SHA256 file hashing of all output files, saved as “Processing_Details_and_Hashes.txt”
