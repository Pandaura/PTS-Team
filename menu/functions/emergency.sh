#!/bin/bash
#
# Title:          PTS Emergency Log Gen
# org.Author(s):  Admin9705
# Mod:            MrDoob MainDev from PTS
# GNU:        General Public License v3.0
################################################################################
source /opt/plexguide/menu/functions/functions.sh
abc="/var/plexguide"

emergency(){
  mkdir -p /opt/appdata/plexguide/emergency
  variable ${abc}/emergency.display "On"
  if [[ $(ls /opt/appdata/plexguide/emergency) != "" ]]; then

    # If not on, do not display emergency logs
    if [[ $(cat /var/plexguide/emergency.display) == "On" ]]; then

      tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  Emergency & Warning Log Generator 
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NOTE: This can be turned [On] or Off in Settings!

EOF

      countmessage=0
      while read p; do
        let countmessage++
        echo -n "${countmessage}. " && cat /opt/appdata/plexguide/emergency/$p
      done <<<"$(ls /opt/appdata/plexguide/emergency)"

      echo
      read -n 1 -s -r -p "Acknowledge Info | Press [ENTER]"
      echo
    else
      touch ${abc}/emergency.log
    fi
  fi
}