#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
source /opt/plexguide/menu/functions/functions.sh
source /opt/plexguide/menu/functions/watchtower.sh
source /opt/plexguide/menu/functions/install.sh
#source /opt/plexguide/menu/functions/serverid.sh

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
  4)
    if [[ "$switchcheck" == "On" ]]; then
      echo "Off" >/var/plexguide/pgui.switch
      docker stop pgui &>/dev/null &
      docker rm pgui &>/dev/null &
      service localspace stop
	  systemctl daemon-reload
      rm -f /etc/systemd/system/localspace.servive
      rm -f /etc/systemd/system/mountcheck.service
	  clear
    tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️   WOOT WOOT: Process Complete!
✅️   WOOT WOOT: UI Removed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

    else
      echo "On" >/var/plexguide/pgui.switch
      ansible-playbook /opt/coreapps/apps/pgui.yml
      systemctl daemon-reload
      service localspace start
	  clear
    tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️   WOOT WOOT: Process Complete!
✅️   WOOT WOOT: UI installed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    fi
    setstart
    ;;
  5)
    if [[ "$emdisplay" == "On" ]]; then
      echo "Off" >/var/plexguide/emergency.display
    else echo "On" >/var/plexguide/emergency.display; fi
    setstart ;;
  6) bash /opt/plexguide/menu/functions/network.sh && clear && setstart ;;
  7) serverid && clear && setstart ;;
  
  99) bash /opt/plexguide/menu/functions/tshoot.sh && clear && setstart ;;
  z) exit ;;
  Z) exit ;;
  *) setstart ;;
  esac
}

setstart
