#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

mainstart() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Box Apps Interface Selection    
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬  PTS Box installs a series of Core and Community applications!

[1] PTS          : Core
[2] PGBlitzs Box : Community [ be careful ]
[3] Apps         : Removal
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  # Standby
  read -p 'Type a Number | Press [ENTER]: ' typed </dev/tty

  if [ "$typed" == "1" ]; then
    bash /opt/plexguide/menu/pgbox/pgboxcore.sh
  elif [ "$typed" == "2" ]; then
    bash /opt/plexguide/menu/pgbox/pgboxcommunity.sh
  elif [ "$typed" == "3" ]; then
    bash /opt/plexguide/menu/removal/removal.sh
  elif [ "$typed" == "Z" ] || [ "$typed" == "z" ]; then
    exit
  else
    mainstart
  fi
}

mainstart
