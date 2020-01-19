#!/bin/bash
#
# Title:      Endbanner Plex_Autoscan
# Author(s):  MrDoob
# GNU:        General Public License v3.0
################################################################################
timer() {
seconds=90; date1=$((`date +%s` + $seconds)); 
while [ "$date1" -ge `date +%s` ]; do 
  echo -ne "$(date -u --date @$(($date1 - `date +%s` )) +%H:%M:%S)\r"; 
done
}


pasdeployed() {
PAS_CONFIG="/opt/plex_autoscan/config/config.json"
SERVER_IP=$(cat ${PAS_CONFIG} | jq -r .SERVER_IP)
SERVER_PORT=$(cat ${PAS_CONFIG} | jq -r .SERVER_PORT)
SERVER_PASS=$(cat ${PAS_CONFIG} | jq -r .SERVER_PASS)
domain=$(cat /var/plexguide/server.domain)

  tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💬 NOTE / INFO MANUAL EDITS IS NEEDED NOW
   ( Failure to follow these steps can lead to problems. )
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1.)  Link now PAS to each *arr     ( see wiki )
     "http://${SERVER_IP}:${SERVER_PORT}/${SERVER_PASS}"

2.)  Edit Plex Scan Part           ( see wiki )
3.)  Open your PAS link in Browser ( see above )
     type your Movie Folder or TV Folder in the field

     SAMPLE :
     /mnt/unionfs/movies/
     /mnt/unionfs/tv/
     /mnt/unionfs/music/

4.)  open https://plex.${domain}/web
5.)  check top right ->
     -->  Settings --> Activity --> Alerts
     and check the running scan     ( this can take a long time )
6.)  wait until finished
7.)  Restart your Plex Docker       (  see below )
8.)  Start Downloading again
9.)  Have fun

   ( Failure to follow these steps can lead to problems. )
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💬 Plex Docker Restart now

[ Y ] Restart Plex Docker now !
[ N ] No. I will do it myself later.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

timer
donepasread
}
doneopasread() {
   read -p '↘️  Type [ Y ] or [ N ] | Press [ENTER]: ' typed </dev/tty

  case $typed in
  Y) docker restart plex && exit ;;
  y) docker restart plex && exit ;;
  N) exit ;;
  n) exit ;;
  *) clear && pasdeployed ;;
  esac
}

pasundeployed() {
printf '
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💬 NOTE / INFO MANUAL EDITS IS NEEDED NOW
   ( Failure to follow these steps can lead to problems. )
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1.)  Stop Downloading
2.)  Wait until all files have been uploaded
3.)  Rescan all Media Libraries on Plex
4.)  Wait until finished Plex full rescan

   ( Failure to follow these steps can lead to problems. )
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
'
timer
doneokay
}

doneokay() {
 echo
  read -p 'Confirm Info | PRESS [ENTER] ' typed </dev/tty
}
