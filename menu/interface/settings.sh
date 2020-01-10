#!/bin/bash
#
# Title:      PTS Settings Layout
# Author(s):  Admin9705 - Deiteq
# Mode from MrDoob for PTS
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
source /opt/plexguide/menu/functions/functions.sh
source /opt/plexguide/menu/functions/install.sh
################################################################################
source /opt/plexguide/menu/functions/serverid.sh
source /opt/plexguide/menu/functions/nvidia.sh
source /opt/plexguide/menu/functions/uichange.sh

rcdupe() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 RClone dedupe
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
INFO AND NOTE
Interactively find duplicate files and delete/rename them.
Synopsis
By default dedupe interactively finds duplicate files and offers 
to delete all but one or rename them to be different. 
Only useful with Google Drive which can have duplicate file names.

In the first pass it will merge directories with the same name. 
It will do this iteratively until all the identical directories have been merged.

The dedupe command will delete all but one of any identical 
(same md5sum) files it finds without confirmation. 
This means that for most duplicated files the dedupe command will 
not be interactive.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[ Y ] Deploy rclone dedupe weekly
[ N ] Remove rclone dedupe weekly

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[ Z ] EXIT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

  # Standby
  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  Y) ansible-playbook /opt/plexguide/menu/rclonededupe/dupedeploy.yml && setstart ;;
  y) ansible-playbook /opt/plexguide/menu/rclonededupe/dupedeploy.yml && setstart ;;
  N) ansible-playbook /opt/plexguide/menu/rclonededupe/duperemove.yml && setstart ;;
  n) ansible-playbook /opt/plexguide/menu/rclonededupe/duperemove.yml && setstart ;;
  z) setstart ;;
  Z) setstart ;;
  *) setstart ;;
  esac
}
# Menu Interface
setstart() {
### executed parts 
touch /var/plexguide/pgui.switch
 dstatus=$(docker ps --format '{{.Names}}' | grep "pgui")
  if [[ "pgui" != "$dstatus" ]]; then
  echo "Off" >/var/plexguide/pgui.switch
  elif [[ "pgui" == "$dstatus" ]]; then
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

[1] MultiHD                  :  Add Multiple HDs and/or Mount Points to MergerFS
[2] Comm UI                  :  [ $switchcheck ] | Port [ $ports ] | pgui.$domain
[3] Emergency Display        :  [ $emdisplay ]
[4] System & Network Auditor
[5] Server ID change         : Change your ServerID
[6] NVIDIA Docker Role       : NVIDIA Docker
[7] RCLONE DEDUPE            

[99] TroubleShoot            : PreInstaller

[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

  # Standby
  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1) bash /opt/plexguide/menu/multihd/multihd.sh ;;
  2) uichange && clear && setstart ;;
  3)
    if [[ "$emdisplay" == "On" ]]; then
      echo "Off" >/var/plexguide/emergency.display
    else echo "On" >/var/plexguide/emergency.display; fi
    setstart ;;
  4) bash /opt/plexguide/menu/functions/network.sh && clear && setstart ;;
  5) setupnew && clear && setstart ;;
  6) nvidia && clear && setstart ;;
  7) rcdupe ;; 
###########################################################################
  99) bash /opt/plexguide/menu/functions/tshoot.sh && clear && setstart ;;
  z) exit ;;
  Z) exit ;;
  *) setstart ;;
  esac
}

setstart
