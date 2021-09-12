#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
source /opt/plexguide/menu/functions/functions.sh
# Menu Interface
question1() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📂  System & network auditor
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] System & network benchmark - Basic
[2] System & network benchmark - Advanced

[3] Simple speedtest

EOF
end_menu
  # Standby
  read -p '💬  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1)
    sudo wget -qO- bench.sh | bash
    echo ""
    read -p ' Process Complete | Press [ENTER] ' typed </dev/tty
    question1
    ;;
  2)
    clear
    echo ""
	curl -LsO git.io/bench.sh; chmod +x bench.sh && ./bench.sh -a
    echo ""
    read -p ' Process Complete | Press [ENTER] ' typed </dev/tty
    question1
    ;;
  3)
	curl -LsO git.io/bench.sh; chmod +x bench.sh && ./bench.sh -speed
    echo ""
    read -p ' Process Complete | Press [ENTER] ' typed </dev/tty
	question1 ;;
  z) exit ;;
  Z) exit ;;
  *) question1 ;;
  esac
}

question1
