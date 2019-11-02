# KEY VARIABLE RECALL & EXECUTION
mkdir -p /var/plexguide/pgscan
mkdir -p /opt/appdata/pgscan

# FUNCTIONS START ##############################################################

# FIRST FUNCTION
variable() {
  file="$1"
  if [ ! -e "$file" ]; then echo "$2" >$1; fi
}

deploycheck() {
  dcheck=$(systemctl is-active plex_autoscan.service)
  if [ "$dcheck" == "active" ]; then
    dstatus="✅ DEPLOYED"
  else dstatus="⚠️ NOT DEPLOYED"; fi
}
userstatus() {
  userdep=$(cat /var/plexguide/plex.pw)
  if [ "$userdep" != "" ]; then
    ustatus="✅ DEPLOYED"
  else ustatus="⚠️ NOT DEPLOYED"; fi
}
tokenstatus() {
  ptokendep=$(cat /var/plexguide/plex.token)
  if [ "$ptokendep" != "" ]; then
  PGSELFTEST=$(curl -LI "http://localhost:32400/system?X-Plex-Token=$(cat /opt/plex_autoscan/config/config.json | jq .PLEX_TOKEN | sed 's/"//g' )"  -o /dev/null -w '%{http_code}\n' -s)
  	if [[ $PGSELFTEST -ge 200 && $PGSELFTEST -le 299 ]]; then
  	  pstatus="✅ DEPLOYED"
	  else
	  pstatus="❌ DEPLOYED BUT PAS TOKEN FAILED"
	fi
  else pstatus="⚠️ NOT DEPLOYED"; fi
}

plexcheck() {
  pcheck=$(docker ps | grep "\<plex\>")
  if [ "$pcheck" == "" ]; then

    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! - Plex is Not Installed or Running! Exiting!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    read -p 'Confirm Info | PRESS [ENTER] ' typed </dev/tty
    exit
  fi
}

user() {
  touch /var/plexguide/plex.pw
  user=$(cat /var/plexguide/plex.pw)
  if [ "$user" == "" ]; then
    bash /opt/plexguide/menu/pgscan/scripts/plex_pw.sh
  fi
}
token() {
  touch /opt/appdata/pgscan/plex.token
  ptoken=$(cat /opt/appdata/pgscan/plex.token)
  if [ "$ptoken" == "" ]; then
    bash /opt/plexguide/menu/pgscan/scripts/plex_token.sh
    ptoken=$(cat /opt/appdata/pgscan/plex.token)
    if [ "$ptoken" == "" ]; then
      tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! - Failed to Generate a Valid Plex Token! Exiting Deployment!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
      read -p 'Confirm Info | PRESS [ENTER] ' typed </dev/tty
      exit
    fi
  fi
}
# BAD INPUT
badinput() {
  echo
  read -p '⛔️ ERROR - BAD INPUT! | PRESS [ENTER] ' typed </dev/tty
  question1
}

works(){
 echo
  read -p 'Confirm Info | PRESS [ENTER] ' typed </dev/tty
  question1
}
credits(){
clear

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Plex_AutoScan Credits 
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

           _                         _                            
     _ __ | | _____  __   __ _ _   _| |_ ___  ___  ___ __ _ _ __  
    | '_ \| |/ _ \ \/ /  / _` | | | | __/ _ \/ __|/ __/ _` | '_ \ 
    | |_) | |  __/>  <  | (_| | |_| | || (_) \__ \ (_| (_| | | | |
    | .__/|_|\___/_/\_\  \__,_|\__,_|\__\___/|___/\___\__,_|_| |_|
    |_|                                                           
 
#########################################################################
# Author:   l3uddz                                                      #
# URL:      https://github.com/l3uddz/plex_autoscan                     #
# Coder of plex_autoscan                                                #
# --                                                                    #
# Author(s):     l3uddz, desimaniac                                     #
# URL:           https://github.com/cloudbox/cloudbox                   #
# Coder of plex_autoscan role                                           #
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

doneenter(){
 echo
  read -p 'All done | PRESS [ENTER] ' typed </dev/tty
  question1
}

# FIRST QUESTION
question1() {

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Plex_AutoScan Interface  || l3uddz/plex_autoscan
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE : Plex_AutoScan are located  in /opt/plex_autoscan

[1] Deploy Plex Username & Plex Passwort  [ $ustatus ]
[2] Deploy Plex Token                     [ $pstatus ]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[A] Deploy Scan                           [ $dstatus ]
[D] PlexAutoScan Domain
[S] Plex_AutoScan Settings

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Z] - Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  if [ "$typed" == "1" ]; then
		bash /opt/plexguide/menu/pgscan/scripts/plex_pw.sh
		question1 
  elif [ "$typed" == "2" ]; then
		bash /opt/plexguide/menu/pgscan/scripts/plex_token.sh
		question1 
  elif [[ "$typed" == "A" || "$typed" == "a"  ]]; then
		ansible-playbook /opt/plexguide/menu/pg.yml --tags plex_autoscan
		question1
  elif [[ "$typed" == "D" || "$typed" == "d" ]]; then
		showupdomain
  elif [[ "$typed" == "S" || "$typed" == "s" ]]; then
		plexautoscansettings
elif [[ "$typed" == "Z" ]] || [[ "$typed" == "z" ]]; then
  bash /opt/plexguide/menu/start/start.sh
  exit
fi
}
showupdomain() {
clear
PAS_CONFIG="/opt/plex_autoscan/config/config.json"

SERVER_IP=$(ip a | grep glo | awk '{print $2}' | head -1 | cut -f1 -d/)
SERVER_PORT=$(cat ${PAS_CONFIG} | jq -r .SERVER_PORT)
SERVER_PASS=$(cat ${PAS_CONFIG} | jq -r .SERVER_PASS)

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Plex_AutoScan Domain Interface
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

"Your Plex Autoscan URL:"

"http://${SERVER_IP}:${SERVER_PORT}/${SERVER_PASS}"

Press Enter to Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

 if [ "$typed" == "" ]; then
    question1
  elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then
    exit
  else works; fi
}

plexautoscansettings() {
clear

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Plex_AutoScan Settings Interface
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[ 1 ] Show last 50 lines of plex_autoscan.log
[ 2 ] Update Sections

[ 3 ] Credits 

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  if [ "$typed" == "1" ]; then
		tail -n 50 /opt/plex_autoscan/plex_autoscan.log
		doneenter
  elif [ "$typed" == "2" ]; then
        python /opt/plex_autoscan/scan.py update_sections
		doneenter
  elif [ "$typed" == "3" ]; then
        credits
		doneenter	
  elif [[ "$typed" == "A" || "$typed" == "a"  ]]; then
		badinput
  elif [[ "$typed" == "D" || "$typed" == "d" ]]; then
		badinput
  elif [[ "$typed" == "S" || "$typed" == "S" ]]; then
		badinput
  elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then
    question1
  else question1; fi
}

# FUNCTIONS END ##############################################################
plexcheck
userstatus
tokenstatus
deploycheck
question1
