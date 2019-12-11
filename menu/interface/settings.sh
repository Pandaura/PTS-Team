#!/bin/bash
#
# Title:      PTS Settings Layout
# Author(s):  Admin9705 - Deiteq
# Mode from MrDoob for PTS
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
source /opt/plexguide/menu/functions/functions.sh
source /opt/plexguide/menu/functions/watchtower.sh
source /opt/plexguide/menu/functions/install.sh
################################################################################
source /opt/plexguide/menu/functions/serverid.sh
source /opt/plexguide/menu/functions/nvidia.sh
source /opt/plexguide/menu/functions/uichange.sh


# Menu Interface
setstart() {
### executed parts 
touch /var/plexguide/pgui.switch
 dstatus=$(docker ps --format '{{.Names}}' | grep "pgui")
  if [ "pgui" != "$dstatus" ]; then
  echo "Off" >/var/plexguide/pgui.switch
  elif [ "pgui" == "$dstatus" ]; then
   echo "On" >/var/plexguide/pgui.switch
  else echo ""
  fi

  # Declare Ports State
  udisplay=$(cat /var/plexguide/emergency.display)

    if [[ "$udisplay" == "On" ]]; then
     echo "CLOSED" >/var/plexguide/http.ports
    else echo "8555" >/var/plexguide/http.ports; fi

### read Variables
  emdisplay=$(cat /var/plexguide/emergency.display)
  switchcheck=$(cat /var/plexguide/pgui.switch)
  domain=$(cat /var/plexguide/server.domain)
  ports=$(cat /var/plexguide/http.ports)

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Settings Interface Menu
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Download Path            :  Change the Processing Location
[2] MultiHD                  :  Add Multiple HDs and/or Mount Points to MergerFS
[3] WatchTower               :  Auto-Update Application Manager
[4] Comm UI                  :  [ $switchcheck ] | Port [ $ports ] | pgui.$domain
[5] Emergency Display        :  [ $emdisplay ]
[6] System & Network Auditor
[7] Server ID change         : Change your ServerID
[8] NVIDIA Docker Role       : NVIDIA Docker

[99] TroubleShoot            : PreInstaller

[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

  # Standby
  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1) bash /opt/plexguide/menu/dlpath/dlpath.sh && setstart ;;
  2) bash /opt/plexguide/menu/multihd/multihd.sh ;;
  3) watchtower && clear && setstart ;;
  4) uichange && clear && setstart ;;
  5)
    if [[ "$emdisplay" == "On" ]]; then
      echo "Off" >/var/plexguide/emergency.display
    else echo "On" >/var/plexguide/emergency.display; fi
    setstart ;;
  6) bash /opt/plexguide/menu/functions/network.sh && clear && setstart ;;
  7) setupnew && clear && setstart ;;
  8) nvidia && clear && setstart ;;
###########################################################################
  99) bash /opt/plexguide/menu/functions/tshoot.sh && clear && setstart ;;
  z) exit ;;
  Z) exit ;;
  *) setstart ;;
  esac
}

setstart