#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
source /opt/plexguide/menu/functions/functions.sh
source /opt/plexguide/menu/functions/install.sh

sudocheck() {
  if [[ $EUID -ne 0 ]]; then
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  You Must Execute as a SUDO USER (with sudo) or as ROOT!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    exit 1
  fi
}

downloadpg() {
  rm -rf /opt/plexguide
  git clone --single-branch https://github.com/PTS-Team/PTS-Team.git /opt/plexguide  1>/dev/null 2>&1
  ansible-playbook /opt/plexguide/menu/alias/alias.yml  1>/dev/null 2>&1
  rm -rf /opt/plexguide/place.holder >/dev/null 2>&1
  rm -rf /opt/plexguide/.git* >/dev/null 2>&1
}

missingpull() {
  file="/opt/plexguide/menu/functions/install.sh"
  if [ ! -e "$file" ]; then
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  Base folder went missing!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    sleep 2
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 🍖  NOM NOM - Re-Downloading PTS for BoneHead User!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    sleep 2
    downloadpg
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️  Repair Complete! Standby!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    sleep 2
  fi
}

owned() {
  chown -cR 1000:1000 /opt/plexguide 1>/dev/null 2>&1
  chmod -R 775 /opt/plexguide 1>/dev/null 2>&1
}

exitcheck() {
  bash /opt/plexguide/menu/version/file.sh
  file="/var/plexguide/exited.upgrade"
  if [ ! -e "$file" ]; then
    bash /opt/plexguide/menu/interface/ending.sh
  else
    rm -rf /var/plexguide/exited.upgrade 1>/dev/null 2>&1
    echo ""
    bash /opt/plexguide/menu/interface/ending.sh
  fi
}
