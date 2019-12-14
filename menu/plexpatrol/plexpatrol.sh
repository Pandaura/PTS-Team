#!/bin/bash
#
# Title:      Plex Patrol
# org.Author(s):  Admin9705
# Mod from MrDoob for PTS over role based installs
# GNU:        General Public License v3.0
################################################################################
source /opt/plexguide/menu/functions/functions.sh
source /opt/plexguide/menu/functions/install.sh

# KEY VARIABLE RECALL & EXECUTION
mkdir -p /var/plexguide/plexpatrol
rm -rf /var/plexguide/pgpatrol

# FUNCTIONS START ##############################################################
# FIRST FUNCTION
variable() {
  file="$1"
  if [ ! -e "$file" ]; then echo "$2" >$1; fi
}

doneenter() {
 echo
  read -p 'All done | PRESS [ENTER] ' typed </dev/tty
  question1
}

deploycheck() {
  dcheck=$(systemctl is-active plexpatrol.service)
  if [ "$dcheck" == "active" ]; then
    dstatus="✅ DEPLOYED"
  else dstatus="⚠️ NOT DEPLOYED"; fi
}

plexcheck() {
  pcheck=$(docker ps --format {{.Names}} | grep "plex")
  if [ "$pcheck" == "" ]; then
printf'
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! - Plex is Not Installed or Running! Exiting!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
'
    read -p 'Confirm Info | PRESS [ENTER] ' typed </dev/tty
    exit 0
  fi
}

token() {
  ptokendep=$(cat /var/plexguide/plexpatrol/plex.token)
  if [ "$ptokendep" != "" ]; then
        if [[ ! -f "/opt/appdata/plexpatrol/settings.ini" ]]; then
                pstatus="❌ DEPLOYED BUT PAPTROL CONFIG MISSING";
        else
                PGSELFTEST=$(curl -LI "http://$(hostname -I | awk '{print $1}'):32400/system?X-Plex-Token=$(cat /opt/appdata/plexpatrol/settings.ini | grep "SERVER_TOKEN" | awk '{print $3}')" -o /dev/null -w '%{http_code}\n' -s)
                if [[ $PGSELFTEST -ge 200 && $PGSELFTEST -le 299 ]]; then  pstatus="✅ DEPLOYED"
                else pstatus="❌ DEPLOYED BUT PATROL TOKEN FAILED"; fi
        fi
  else ctoken; fi
  #else pstatus="⚠️ NOT DEPLOYED"; fi
}
ctoken() {
bash /opt/plexguide/menu/plexpatrol/token.sh && clear
}

# BAD INPUT
badinput() {
  echo
  read -p '⛔️ ERROR - BAD INPUT! | PRESS [ENTER] ' typed </dev/tty
  question1
}

selection1() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Instantly Kick Video Transcodes?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] False
[2] True

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1) echo -e "false" >/var/plexguide/plexpatrol/video.transcodes && question1 ;;
  2) echo -e "true" >/var/plexguide/plexpatrol/video.transcodes && question1 ;;
  *) badinput ;;
  esac
}
selection2() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Instantly Kick 4k - Video Transcodes?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] False
[2] True

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1) echo -e "false" >/var/plexguide/plexpatrol/video.transcodes4k && question1 ;;
  2) echo -e "true" >/var/plexguide/plexpatrol/video.transcodes4k && question1 ;;
  *) badinput ;;
  esac
}
selection3() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Instantly Kick Audio Transcodes?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] False
[2] True

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1) echo -e "false" >/var/plexguide/plexpatrol/audio.transcodes && question1 ;;
  2) echo -e "true" >/var/plexguide/plexpatrol/audio.transcodes && question1 ;;
  *) badinput ;;
  esac
}
selection4() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Limit Amount of Different IPs a User Can Make?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Set a Number from [ 1 ] - [ 10 ]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty
  if [[ "$typed" -ge "1" && "$typed" -le "10" ]]; then
    echo -e "$typed" >/var/plexguide/plexpatrol/multiple.ips && question1
  else badinput; fi
}
selection5() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Limit How Long a User Can Pause For!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Set a Number from [ 5 ] - [ 120 ] Mintues

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty
  if [[ "$typed" -ge "5" && "$typed" -le "120" ]]; then
    echo -e "$typed" >/var/plexguide/plexpatrol/kick.minutes && question1
  else badinput; fi
}
selection6() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Check Interval # how often to check the active streams in seconds
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Set a Number from [ 60 ] - [ 240 ] seconds

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty
  if [[ "$typed" -ge "59" && "$typed" -le "241" ]]; then
    echo -e "$typed" >/var/plexguide/plexpatrol/check.interval && question1
  else badinput; fi
}
selection7() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Remove Plex Patrol  || l3uddz/plex_patrol
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[ 1 ] - NO

[ 2 ] - YES

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

 case $typed in
 1) question1 ;; 
 2) ansible-playbook /opt/plexguide/menu/plexpatrol/remove-plexpatrol.yml && question1 ;;
 *) badinput ;;
 esac
}
credits(){
clear
chk=$(figlet Plex Patrol | lolcat )

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Plex Patrol Credits 
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

$chk

#########################################################################
# Author:   l3uddz                                                      #
# URL:      https://github.com/l3uddz/plex_patrol                       #
# Coder of plex_patrol                                                  #
# --                                                                    #
# Author(s):     l3uddz, desimaniac                                     #
# URL:           https://github.com/cloudbox/cloudbox                   #
# --                                                                    #
#         Part of the Cloudbox project: https://cloudbox.works          #
#########################################################################
#                   GNU General Public License v3.0                     #
#########################################################################
EOF

 echo
  read -p 'Confirm Info | PRESS [ENTER] ' typed </dev/tty
  clear && question1
}
# FIRST QUESTION
question1() {
deploycheck
  video=$(cat /var/plexguide/plexpatrol/video.transcodes)
  video4k=$(cat /var/plexguide/plexpatrol/video.transcodes4k)
  ips=$(cat /var/plexguide/plexpatrol/multiple.ips)
  minutes=$(cat /var/plexguide/plexpatrol/kick.minutes)
  audio=$(cat /var/plexguide/plexpatrol/audio.transcodes)
  interval=$(cat /var/plexguide/plexpatrol/check.interval)

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Plex - Patrol Interface || l3uddz/plex_patrol
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Plex Token                               [ $pstatus ]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Instantly Kick Video Transcodes?      [ $video ]
[2] Instantly Kick Video 4k Transcodes?   [ $video4k ]
[3] Instantly Kick Audio Transcodes?      [ $audio ]
[4] Multiple IPs for UserName             [ $ips ]
[5] Minutes  | Kick Paused Transcode?     [ $minutes ]
[6] Check Interval                        [ $interval ]

[7] Deploy Plex - Patrol                  [ $dstatus ]
[8] Remove Plex - Patrol

[C] Credits

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[Z] Exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1) selection1 && clear && question1 ;;
  2) selection2 && clear && question1 ;;
  3) selection3 && clear && question1 ;;
  4) selection4 && clear && question1 ;;
  5) selection5 && clear && question1 ;;
  6) selection6 && clear && question1 ;;
  7) ansible-playbook /opt/plexguide/menu/pg.yml --tags plexpatrol && sleep 5 && clear &&  exit ;;
  8) selection7 && question1 ;;
  C) credits && clear && question1 ;;
  c) credits && clear && question1 ;;
  z) exit ;;
  Z) exit ;;
  *) question1 ;;
  esac
}

# FUNCTIONS END ##############################################################
plexcheck
token
variable /var/plexguide/plexpatrol/video.transcodes "NON-SET"
variable /var/plexguide/plexpatrol/video.transcodes4k "NON-SET"
variable /var/plexguide/plexpatrol/audio.transcodes "NON-SET"
variable /var/plexguide/plexpatrol/check.interval "NON-SET"
variable /var/plexguide/plexpatrol/multiple.ips "NON-SET"
variable /var/plexguide/plexpatrol/kick.minutes "NON-SET"
deploycheck
question1
