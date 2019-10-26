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
  if [ "$dcheck" == "" ]; then
    dstatus="✅ DEPLOYED"
  else dstatus="⚠️ NOT DEPLOYED"; fi
}
userstatus() {
  userdep=$(cat /var/plexguide/plex.pw)
  if [ "$userdep" == "" ]; then
    ustatus="✅ DEPLOYED"
  else ustatus="⚠️ NOT DEPLOYED"; fi
 }
tokenstatus() {
  ptokendep=$(cat /opt/appdata/pgscan/plex.token)
  if [ "$ptokendep" == "" ]; then
    pstatus="✅ DEPLOYED"
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

# FIRST QUESTION
question1() {

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Scan Interface
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Deploy Plex Username & Plex Passwort  [ $ustatus   ]
[2] Deploy Plex Token                     [ $pstatus ]


[A] Deploy Scan                           [ $dstatus ]
[D] PlexAutoScan Domain 

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
		question1z
  elif [[ "$typed" == "D" || "$typed" == "d" ]]; then
		showupdomain
  elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then
    exit
  else badinput; fi
}
showupdomain() {
clear
PAS_CONFIG="/opt/plex_autoscan/config/config.json"

SERVER_IP=$(ip a | grep glo | awk '{print $2}' | head -1 | cut -f1 -d/)
SERVER_PORT=$(cat ${PAS_CONFIG} | jq -r .SERVER_PORT)
SERVER_PASS=$(cat ${PAS_CONFIG} | jq -r .SERVER_PASS)

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Scan Interface
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

# FUNCTIONS END ##############################################################
plexcheck
user
token
deploycheck
question1
