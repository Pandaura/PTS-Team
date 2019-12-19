#!/bin/bash
#
# Title:      Endbanner Plex_Autoscan
# Author(s):  MrDoob
# GNU:        General Public License v3.0
################################################################################
pasdeployed() {
PAS_CONFIG="/opt/plex_autoscan/config/config.json"

SERVER_IP=$(ip a | grep glo | awk '{print $2}' | head -1 | cut -f1 -d/)
SERVER_PORT=$(cat ${PAS_CONFIG} | jq -r .SERVER_PORT)
SERVER_PASS=$(cat ${PAS_CONFIG} | jq -r .SERVER_PASS)

  tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💬 NOTE / INFO MANUAL EDITS IS NEEDED NOW
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1.)  Link now PAS to each *arr     ( see wiki )
"http://${SERVER_IP}:${SERVER_PORT}/${SERVER_PASS}"

2.)  Edit Plex Scan Part           ( see wiki )
3.)  Restart your Plex Docker
4.)  Start Downloading again
5.)  Have fun

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💬 Plex Docker Restart now

[ Y ] Restart Plex Docker now !
[ N ] No. I will do it myself later.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p '↘️  Type [ Y ] or [ N ] | Press [ENTER]: ' typed </dev/tty

  case $typed in
  Y) docker restart plex && exit ;; 
  y) docker restart plex && exit ;;
  N) exit 0 ;;
  n) exit 0 ;;
  *) exit 0 ;;
  esac
}

pasundeployed() {
printf '
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💬 NOTE / INFO MANUAL EDITS IS NEEDED NOW
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1.)  Stop Downloading
2.)  Wait until all files have been uploaded
3.)  Rescan all Media Libraries on Plex 
4.)  Wait until finished Plex full rescan

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
'
  read -p 'Confirm Info | PRESS [ENTER] ' typed </dev/tty
}
