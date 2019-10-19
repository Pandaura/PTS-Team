#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
source /opt/plexguide/menu/functions/functions.sh
source /opt/plexguide/menu/functions/install.sh
# Menu Interface
setstart() {
### executed parts 
touch /var/plexguide/pgui.switch
 dstatus=$(docker ps --format '{{.Names}}' | grep "pgui")
  if [ "pgui" != "$dstatus" ]; then
  echo "Off" >/var/plexguide/pgui.switch
  fi

  # Declare Ports State
  ports=$(cat /var/plexguide/server.ports)
  if [ "$ports" != "OPEN" ]; then
    echo "8555" >/var/plexguide/http.ports
  else ports="CLOSED"; fi


### read Variables
  emdisplay=$(cat /var/plexguide/emergency.display)
  switchcheck=$(cat /var/plexguide/pgui.switch)
  domain=$(cat /var/plexguide/server.domain)
  ports=$(cat /var/plexguide/http.ports)

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Settings Interface Menu
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Download Path    :  Change the Processing Location
[2] MultiHD          :  Add Multiple HDs and/or Mount Points to MergerFS
[3] Processor        :  Enhance the CPU Processing Power
[4] WatchTower       :  Auto-Update Application Manager
[5] Change Time      :  Change the Server Time
[6] Comm UI          :  [ $switchcheck ] | Port [ $ports ] | pgui.$domain
[7] Emergency Display:  [ $emdisplay ]

[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

  # Standby
  read -p 'Type a Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1)
    bash /opt/plexguide/menu/dlpath/dlpath.sh
    setstart
    ;;
  2)
    bash /opt/plexguide/menu/pgcloner/multihd.sh
    ;;
  3)
    bash /opt/plexguide/menu/processor/processor.sh
    setstart
    ;;
  4)
    watchtower
    ;;
  5)
    dpkg-reconfigure tzdata
    ;;
  6)

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
✅️   WOOT WOOT: PGUI Removed
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
✅️   WOOT WOOT: PGUI installed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    fi
    setstart
    ;;
  7)
    if [[ "$emdisplay" == "On" ]]; then
      echo "Off" >/var/plexguide/emergency.display
    else echo "On" >/var/plexguide/emergency.display; fi
    setstart
    ;;
  z)
    exit
    ;;
  Z)
    exit
    ;;
  *)
    setstart
    ;;
  esac

}

setstart
