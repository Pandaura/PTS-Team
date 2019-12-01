#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
mainstart() {
mkdir -p /opt/ptsupdate 1>/dev/null 2>&1
git clone --single-branch https://github.com/PTS-Team/PTS-Update.git /opt/ptsupdate 1>/dev/null 2>&1
chown -cR 100:1000 /opt/ptsupdate 1>/dev/null 2>&1 
chmod -cR 775 /opt/ptsupdate 1>/dev/null 2>&1
apt-get install dos2unix -yqq && dos2unix /opt/ptsupdate/update.sh 1>/dev/null 2>&1
ansible-playbook /opt/plexguide/menu/alias/alias.yml 1>/dev/null 2>&1
}

endline() {
  tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Hey Guys we build up a new update panel 
if yousee this , please do follow 

1.) read this part please
2.) do ptsupdate again
3.) have fun ^^

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
}

mainstart
endline
