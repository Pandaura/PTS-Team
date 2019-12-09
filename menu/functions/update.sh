#!/bin/bash
#
# Title:      PTS major file
# org.Author(s):  Admin9705 - Deiteq
# Mod from MrDoob for PTS
# GNU:        General Public License v3.0
################################################################################
source /opt/plexguide/menu/functions/functions.sh

sudocheck() {
  if [[ $EUID -ne 0 ]]; then
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  You Must Execute as a SUDO USER (with sudo) or as ROOT!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    exit 0
  fi
}
mergerfsupdate() {
mgversion="$(curl -s https://api.github.com/repos/trapexit/mergerfs/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')"
mgstored="$(mergerfs -v | grep 'mergerfs version:' | awk '{print $3}')"

tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 mergerfs Update Panel  --local version $mgstored
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

mergerfs installed version = 		$mgstored
mergerfs latest version    = 		$mgversion

[Y] UPDATE to lateste version

[Z] Exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in

  Y) ansible-playbook /opt/plexguide/menu/pg.yml --tags mergerfsupdate ;;
  y) ansible-playbook /opt/plexguide/menu/pg.yml --tags mergerfsupdate ;;
  z) clear && exit ;;
  Z) clear && exit ;;
  *) badinput ;;
  esac
}

rcloneupdate(){
check=$(bash /opt/plexguide/menu/pgui/templates/check.sh >/dev/null 2>&1)
rcversion="$(curl -s https://api.github.com/repos/rclone/rclone/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')"
rcstored="$(rclone --version | awk '{print $2}' | tail -n 3 | head -n 1)"
      tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 rClone Update Panel  			$rcstored
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

rclone installed version = 		$rcstored
rclone latest version 	 = 		$rcversion

[Y] UPDATE to lateste version

[Z] Exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  Y) ansible-playbook /opt/plexguide/menu/pg.yml --tags rcloneinstall && $check ;;
  y) ansible-playbook /opt/plexguide/menu/pg.yml --tags rcloneinstall && $check ;;
  z) clear && exit ;;
  Z) clear && exit ;;
  *) badinput ;;
  esac
}

exitcheck() {
  bash /opt/plexguide/menu/interface/ending.sh
}