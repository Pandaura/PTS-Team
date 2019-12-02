#!/bin/bash
#
# Title:      PTS Community 
# Author:     MrDoob
# URL:        WTFH >-!-< why you need this ^^ 
# GNU:        General Public License v3.0
#
################################################################################

# Starting Actions

startscript() {
        while [ 1 ]; do
                rm -rf /var/plexguide/spaceused.log
                # move and downloads for the UI
                du -sh /mnt/move | awk '{print $1}' >>/var/plexguide/spaceused.log
                du -sh /mnt/downloads | awk '{print $1}' >>/var/plexguide/spaceused.log
                sleep 60
        done
}

# keeps the function in a loop
cheeseballs=0
while [[ "$cheeseballs" == "0" ]]; do startscript; done
