#!/bin/bash
#
# Title:      PTS Settings Layout
# Mode from MrDoob for PTS
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

nvidia() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📂  System & Network Auditor
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Install NVIDIA Docker role

[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1) ansible-playbook /opt/plexguide/menu/pg.yml --tags nvidia ;;
  z) exit && setstart ;;
  Z) exit && setstart ;;
  *) setstart ;;
  esac
}