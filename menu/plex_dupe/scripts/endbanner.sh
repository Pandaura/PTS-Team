#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
timer() {
seconds=90; date1=$((`date +%s` + $seconds)); 
while [ "$date1" -ge `date +%s` ]; do 
  echo -ne "$(date -u --date @$(($date1 - `date +%s` )) +%H:%M:%S)\r"; 
done
}

endbanner() { 
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💬 NOTE / INFO MANUAL EDITS IS NEEDED NOW
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1.) Go to Plex and get all the names of your Plex Libraries you want to find duplicates in.
2.) sudo nano /opt/plex_dupefinder/config.json

Under PLEX_LIBRARIES, type in the Plex Library Name (exactly) 
and specify the Library Type: 1 for movies or 2 for TV shows.
Note: 'Library Type' is not the same as the 'Section ID' of a library.

Format:
"PLEX_LIBRARIES": {
  "LIBRARY_NAME_1": #,
  "LIBRARY_NAME_2": #
},
For basic libraries, this will look like:
"PLEX_LIBRARIES": {
  "Movies": 1,
  "TV": 2
},
For more advanced libraries, it can look like this:
"PLEX_LIBRARIES": {
   "4K Movies": 1,
   "Kids Movies": 1,
   "TV": 2
},
3.) SAVE it
4.) [ sudo ] plex_dupefinder and following the output
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

You will need to make sure that Allow media deletion is enabled in Plex.
In Plex, click the Settings icon -> Server -> Library.
Set the following: --> 
Allow media deletion: enabled
Click SAVE CHANGES.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

These edits must be made by the user! We will not do this for you, so you have to do it yourself!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

timer
doneokay
}

doneokay() {
 echo
  read -p 'Confirm Info | PRESS [ENTER] ' typed </dev/tty
}
