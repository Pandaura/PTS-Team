#!/bin/bash
#
# Title:      PTS ServerID
# org. Author(s):  Admin9705 - Deiteq
# Mod from MrDoob for PTS
# GNU:        General Public License v3.0
################################################################################
touch /var/plexguide/server.id.stored
source /opt/plexguide/menu/functions/functions.sh
abc="/var/plexguide"

serverid() {

if [ "$start" != "$stored" ]; then

 tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
↘️   Establishing New Server ID    💬  Use One Word & Keep it Simple
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '🌏  TYPE Server ID | Press [ENTER]: ' typed </dev/tty

  if [ "$typed" == "" ]; then
    tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! - The Server ID Cannot Be Blank!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    sleep 3
    bash /opt/plexguide/menu/interface/serverid.sh
    exit
  else
    tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️  PASS: New ServerID Set
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

    # Prevents From Repeating
    echo "$typed" >/var/plexguide/server.id
    cat /var/plexguide/server.id >/var/plexguide/server.id.stored

    sleep 3
  fi

fi
}
####
serverid
