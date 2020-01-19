#!/bin/bash
#
# Title:      PTS Plex Dupefinder
# Author(s):  MrDoob
# GNU:        General Public License v3.0
################################################################################

# KEY VARIABLE RECALL & EXECUTION
mkdir -p /var/plex_dupe
source /opt/plexguide/menu/plex_dupe/scripts/endbanner.sh

# FUNCTIONS START ##############################################################
variable() {
  file="$1"
  if [[ ! -e "$file" ]]; then echo "$2" >$1; fi
}

deploycheck() {
file="/opt/plex_dupefinder/config.json"
  if [[ -f $file ]]; then
    dstatus="✅  DEPLOYED"
  else dstatus="⚠️  NOT DEPLOYED"; fi
}

tokenstatus() {
  ptokendep=$(cat /var/plex_dupe/plex.token)
  if [[ "$ptokendep" != "" ]]; then
  PGSELFTEST=$(curl -LI "http://$(hostname -I | awk '{print $1}'):32400/system?X-Plex-Token=$(cat /var/plex_dupe/plex.token)" -o /dev/null -w '%{http_code}\n' -s)
  	if [[ $PGSELFTEST -ge 200 && $PGSELFTEST -le 299 ]]; then
  	  pstatus="✅  DEPLOYED"
	  else
	  pstatus="❌  DEPLOYED BUT Plex_Dupefinder FAILED"
	fi
  else pstatus="⚠️  NOT DEPLOYED"; fi
}

automodestatus() {
  adep=$(cat /var/plex_dupe/plex.authdel)
  if [[ "$adep" == "true" ]]; then
    astatus="✅  AUTO_DELETE = true"
 elif [[ "$adep" == "false" ]]; then
   astatus="✅  AUTO_DELETE = false"
 else astatus="⚠️  NOT DEPLOYED"; fi
}
plexcheck() {
  pcheck=$(docker ps --format {{.Names}} | grep "plex")
  if [[ "$pcheck" == "" ]]; then
	printf '
	━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	⛔️  WARNING! - Plex is Not Installed or Running! Exiting!
	━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	'
    dontwork
  fi
}
token() {
  touch /var/plex_dupe/plex.token
  ptoken=$(cat /var/plex_dupe/plex.token)
  if [[ "$ptoken" == "" ]]; then
    tokencreate
	sleep 2
	X_PLEX_TOKEN=$(sudo cat "/opt/appdata/plex/database/Library/Application Support/Plex Media Server/Preferences.xml" | sed -e 's;^.* PlexOnlineToken=";;' | sed -e 's;".*$;;' | tail -1)
    ptoken=$(cat /var/plex_dupe/plex.token)
    if [[ "$ptoken" != "$X_PLEX_TOKEN" ]]; then
	printf '
	━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	⛔️  WARNING!  Failed to Generate a Valid Plex Token! 
	⛔️  WARNING!  Exiting Deployment!
	━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	'
	dontwork
    fi
  fi
}
tokencreate() {
X_PLEX_TOKEN=$(cat "/opt/appdata/plex/database/Library/Application Support/Plex Media Server/Preferences.xml" | sed -e 's;^.* PlexOnlineToken=";;' | sed -e 's;".*$;;' | tail -1)
echo $X_PLEX_TOKEN >/var/plex_dupe/plex.token
}
# BAD INPUT
badinput() {
  echo
  read -p '⛔️  ERROR - BAD INPUT! | PRESS [ENTER] ' typed </dev/tty
  question1
}

works() {
 echo
  read -p ' Confirm Info | PRESS [ENTER] ' typed </dev/tty
  question1
}

credits() {
clear
chk=$(figlet Plex Dupe finder | lolcat )
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Plex_AutoScan Credits 
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

$chk

#########################################################################
# Author:   l3uddz                                                      #
# URL:      https://github.com/l3uddz/plex_dupefinder                   #
# Coder of plex_dupefinder                                              #
# --                                                                    #
# Author(s):     l3uddz, desimaniac                                     #
# URL:           https://github.com/cloudbox/cloudbox                   #
# Coder of plex_dupefinder role                                          #
# --                                                                    #
#         Part of the Cloudbox project: https://cloudbox.works          #
#########################################################################
#                   GNU General Public License v3.0                     #
#########################################################################
EOF

 echo
  read -p 'Confirm Info | PRESS [ENTER] ' typed </dev/tty
  question1
}

doneenter() {
 echo
  read -p 'All done | PRESS [ENTER] ' typed </dev/tty
  question1
}

authdel() {
clear
status=$(cat /var/plex_dupe/plex.authdel)
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Plex Dupefinder  
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Set it to AUTO_DELETE  [ $status ]

[ 1 ] AUTO_DELETE      : on
[ 2 ] AUTO_DELETE      : off

NOTE / Info
"AUTO_DELETE": true,  - Plex DupeFinder will run in automatic mode.
"AUTO_DELETE": false, - Plex DupeFinder will run in interactive mode. (Default)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1)
	file="/opt/plex_dupefinder/config.json"
	if [[ -f $file ]]; then
	  echo -e "true" >/var/plex_dupe/plex.authdel
	  ansible-playbook /opt/plexguide/menu/pg.yml --tags plex_dupefinder >/dev/null 2>&1
	else echo -e "true" >/var/plex_dupe/plex.authdel ; fi && clear && question1 ;;
  2)
	file="/opt/plex_dupefinder/config.json"
	if [[ -f $file ]]; then
	  echo -e "false" >/var/plex_dupe/plex.authdel
	  ansible-playbook /opt/plexguide/menu/pg.yml --tags plex_dupefinder >/dev/null 2>&1
	else echo -e "false" >/var/plex_dupe/plex.authdel ; fi && clear && question1 ;;
  z) exit ;;
  Z) exit ;;
  *) question1 ;;
  esac
}

remove() {
 
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Remove Plex Dupefinder  || l3uddz/plex_dupefinder
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[ 1 ] - NO

[ 2 ] - YES

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

 case $typed in
 1) clear && question1 ;; 
 2) ansible-playbook /opt/plexguide/menu/plex_dupe/remove/remove.yml && question1 ;;
 *) badinput ;;
 esac
}

# FIRST QUESTION
question1() {

automodestatus
tokenstatus
deploycheck

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Plex Dupefinder Interface   ||    l3uddz/plex_dupefinder
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE : Plex Dupefinder are located  in /opt/plex_dupefinder

[1] Deploy Plex Token                     [ $pstatus ]
[2] Deploy AUTO_DELETE                    [ $astatus ]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[A] Deploy Plex Dupefinder                [ $dstatus ]
[R] Remove Plex Dupefinder
[C] Credits

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Z] - Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1) tokencreate && clear && question1 ;;
  2) authdel && clear && question1 ;;
  A) ansible-playbook /opt/plexguide/menu/pg.yml --tags plex_dupefinder && clear && endbanner && question1 ;;
  a) ansible-playbook /opt/plexguide/menu/pg.yml --tags plex_dupefinder && clear && endbanner && question1 ;;
  R) remove && clear && question1 ;;
  r) remove && clear && question1 ;;
  C) credits && clear && question1 ;;
  c) credits && clear && question1 ;;
  z) exit ;;
  Z) exit ;;
  *) question1 ;;
  esac
}
# FUNCTIONS END ##############################################################
plexcheck
automodestatus
tokenstatus
deploycheck
question1
