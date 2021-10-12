#!/bin/bash
#
# Title:      PTS ServerID
# org. Author(s):  Admin9705 - Deiteq
# Mod from MrDoob for PTS
# GNU:        General Public License v3.0
################################################################################
touch /var/plexguide/server.id.stored
source /opt/plexguide/menu/functions/functions.sh
start=$(cat /var/plexguide/server.id)
stored=$(cat /var/plexguide/server.id.stored)
abc="/var/plexguide"

serverid() {

if [[ "$start" != "$stored" ]]; then
clear
 tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🛈 Create a Server ID   -  Please use one word & keep it simple
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '💬  TYPE Server ID | Press [ENTER]: ' typed </dev/tty

  if [[ "$typed" == "" ]]; then
    tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️ WARNING! - The Server ID cannot be blank!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    sleep 1
    serverid
    exit
  else
    tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🛈 Server ID $(echo -e ${NF}$typed${NC}) stored ✔️
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

    # Prevents From Repeating
    echo "$typed" >${abc}/server.id
    cat ${abc}/server.id >${abc}/server.id.stored
         start=$(cat /var/plexguide/server.id)
         serveridcreate=$(tree -d -L 1 /mnt/gdrive/plexguide/backup | awk '{print $2}' | tail -n +2 | head -n -2 | grep "$(cat /var/plexguide/server.id)")
         if [[ $start != $serveridcreate ]]; then
         rclone mkdir gdrive:/plexguide/backup/$(cat /var/plexguide/server.id) --config /opt/appdata/plexguide/rclone.conf; fi
    sleep 3
  fi

fi
}
####
serverid
