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
🛈 Box Apps Interface Selection
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬  Pandaura installs a series of Core and Community applications

[1] Pandaura          : Core
[2] Pandaura          : Community
---------------------------------
[3] Personal Fork     : Use your own Github fork
[4] Uninstaller       : Remove installed apps
[5] Apps              : Auto Update

[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    
    # Standby
    read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty
    
    case $typed in
        1) clear && bash /opt/plexguide/menu/pgbox/core/core.sh ;;
        2) clear && bash /opt/plexguide/menu/pgbox/community/community.sh ;;
        3) clear && bash /opt/plexguide/menu/pgbox/personal/personal.sh ;;
        4) clear && bash /opt/plexguide/menu/pgbox/remove/removal.sh ;;
        5) clear && bash /opt/plexguide/menu/pgbox/customparts/autobackup.sh ;;
        z) exit ;;
        Z) exit ;;
        *) GCEtest ;;
    esac
}

mainstart2() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🛈 GCE optimized Apps
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] GCE optimized Apps : GCE APPS

[2] Uninstaller        : Remove installed apps

[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    
    read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty
    
    case $typed in
        1) bash /opt/plexguide/menu/pgbox/gce/gcecore.sh ;;
        2) bash /opt/plexguide/menu/pgbox/remove/removal.sh ;;
        z) exit ;;
        Z) exit ;;
        *) GCEtest ;;
    esac
}

GCEtest
