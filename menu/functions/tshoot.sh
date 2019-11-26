#!/bin/bash
#
# Title:      PTS (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://PTS.com - http://github.PTS.com
# GNU:        General Public License v3.0
################################################################################
main(){
# Menu Interface
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚥 TroubleShoot Interface
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Pre-Installer: Force the Entire Process Again
[2] UnInstaller  : Docker & Running Containers | Force Pre-Install
[3] UnInstaller  : PTS

[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

# Standby
  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1) 
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🍖  NOM NOM - Resetting the Starting Variables!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  sleep 3
  echo "0" >/var/plexguide/pg.preinstall.stored
  echo "0" >/var/plexguide/pg.ansible.stored
  echo "0" >/var/plexguide/pg.rclone.stored
  echo "0" >/var/plexguide/pg.python.stored
  echo "0" >/var/plexguide/pg.docker.stored
  echo "0" >/var/plexguide/pg.docstart.stored
  echo "0" >/var/plexguide/pg.watchtower.stored
  echo "0" >/var/plexguide/pg.label.stored
  echo "0" >/var/plexguide/pg.alias.stored
  echo "0" >/var/plexguide/pg.dep.stored

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️ WOOT WOOT - Process Complete! Exit & Restart PTS Now!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  sleep 5
;; 

2) 
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🍖  NOM NOM - Uninstalling Docker & Resetting the Variables!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  sleep 3

  rm -rf /etc/docker
  apt-get purge docker-ce && apt-get autoremove -yqq
  rm -rf /var/lib/docker
  rm -rf /var/plexguide/dep*
  echo "0" >/var/plexguide/pg.preinstall.stored
  echo "0" >/var/plexguide/pg.ansible.stored
  echo "0" >/var/plexguide/pg.rclone.stored
  echo "0" >/var/plexguide/pg.python.stored
  echo "0" >/var/plexguide/pg.docstart.stored
  echo "0" >/var/plexguide/pg.watchtower.stored
  echo "0" >/var/plexguide/pg.label.stored
  echo "0" >/var/plexguide/pg.alias.stored
  echo "0" >/var/plexguide/pg.dep

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️ WOOT WOOT - Process Complete! Exit & Restart PTS Now!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  sleep 5
;; 
3) 
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🍖  NOM NOM - Starting the PTS UnInstaller
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  sleep 3
  echo "uninstall" >/var/plexguide/type.choice && bash /opt/plexguide/menu/core/scripts/main.sh ;; 
  z) exit ;;
  Z) exit ;;
  esac
}

#### function start 

main
