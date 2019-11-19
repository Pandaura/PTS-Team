#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

GCEtest(){
gce=$(cat /var/plexguide/pg.server.deploy)

if [[ $gce == "feeder" ]]; then
mainstart2
else mainstart1; fi
}

mainstart1() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Box Apps Interface Selection    
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬  PTS Box installs a series of Core and Community applications!

[1] PTS          : Core
[2] PTS          : Community
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
    GCEtest
  fi
}
mainstart2() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 GCE APPS optimized Apps    
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] PTS GCE optimized Apps : GCE APPS

[2] Apps                   : Removal

[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  # Standby
  read -p 'Type a Number | Press [ENTER]: ' typed </dev/tty

  if [ "$typed" == "1" ]; then
    bash /opt/plexguide/menu/pgbox/gcecore.sh
  elif [ "$typed" == "2" ]; then
    bash /opt/plexguide/menu/removal/removal.sh
  elif [ "$typed" == "Z" ] || [ "$typed" == "z" ]; then
    exit
  else
    GCEtest
  fi
}

GCEtest
