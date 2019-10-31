#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
source /opt/plexguide/menu/functions/functions.sh
abc="/var/plexguide"
echo "11" >${abc}/pg.watchtower

core watchtower

core() {
  touch ${abc}/pg."${1}".stored
  start=$(cat /var/plexguide/pg."${1}")
  stored=$(cat /var/plexguide/pg."${1}".stored)
  if [ "$start" != "$stored" ]; then
    $1
    cat ${abc}/pg."${1}" >${abc}/pg."${1}".stored
  fi
}

watchtower() {

  file="/var/plexguide/watchtower.wcheck"
  if [ ! -e "$file" ]; then
    echo "4" >${abc}/watchtower.wcheck
  fi

  wcheck=$(cat "${abc}/watchtower.wcheck")
  if [[ "$wcheck" -ge "1" && "$wcheck" -le "3" ]]; then
    wexit="1"
  else wexit=0; fi
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📂  Watch Tower
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬  WatchTower updates your containers soon as possible!

[1] Containers: Auto-Update All
[2] Containers: Auto-Update All Except | Plex & Emby
[3] Containers: Never Update

[Z] - Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  # Standby
  read -p 'Type a Number | Press [ENTER]: ' typed </dev/tty
  if [ "$typed" == "1" ]; then
    watchtowergen
    ansible-playbook /opt/coreapps/apps/watchtower.yml
    echo "1" >${abc}/watchtower.wcheck
  elif [ "$typed" == "2" ]; then
    watchtowergen
    sed -i -e "/plex/d" /tmp/watchtower.set 1>/dev/null 2>&1
    sed -i -e "/emby/d" /tmp/watchtower.set 1>/dev/null 2>&1
    sed -i -e "/jellyfin/d" /tmp/watchtower.set 1>/dev/null 2>&1
    ansible-playbook /opt/coreapps/apps/watchtower.yml
    echo "2" >${abc}/watchtower.wcheck
  elif [ "$typed" == "3" ]; then
    echo null >/tmp/watchtower.set
    ansible-playbook /opt/coreapps/apps/watchtower.yml
    echo "3" >${abc}/watchtower.wcheck
  elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then
    if [ "$wexit" == "0" ]; then
      tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️   WatchTower Preference Must be Set Once!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
      sleep 3
      watchtower
    fi
    exit
  else
    badinput
    watchtower
  fi
}

watchtowergen() {
  bash /opt/coreapps/apps/_appsgen.sh
  bash /opt/communityapps/apps/_appsgen.sh
  while read p; do
    echo -n $p >>/tmp/watchtower.set
    echo -n " " >>/tmp/watchtower.set
  done <${abc}/app.list
}
