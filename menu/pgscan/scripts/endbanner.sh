#!/bin/bash
#
# Title:      Endbanner Plex_Autoscan
# Author(s):  MrDoob
# GNU:        General Public License v3.0
################################################################################
pasdeployed() {
printf '
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💬 NOTE / INFO MANUAL EDITS IS NEEDED NOW
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1.)  Stop downloading
2.)  link now PAS to each arr ( see wiki )
3.)  Edit plex scan part ( see wiki )
4.)  Restart Plex Docker 
5.)  Start downloading again
6.)  Have fun

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💬 Plex Docker Restart now

[ Y ] Restart Plex Docker now !
 
[ N ] No. I will do it myself later
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
'
  read -p '↘️  Type [ Y ] or [ N ] | Press [ENTER]: ' typed </dev/tty

  case $typed in
  Y) docker restart plex && exit 0 ;; 
  y) docker restart plex && exit 0 ;;
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

1.)  Stop downloading
2.)  wait until all files have been uploaded
3.)  Rescan all media libraries on Plex 
4.)  Wait until finished 

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
'
  read -p 'Confirm Info | PRESS [ENTER] ' typed </dev/tty
}
