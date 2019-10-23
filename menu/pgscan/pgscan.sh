#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

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
  dcheck=$(systemctl is-active pgscan.service)
  if [ "$dcheck" == "active" ]; then
    dstatus="✅ DEPLOYED"
  else dstatus="⚠️ NOT DEPLOYED"; fi
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

# Print Plex Autoscan URL
showupdomain() {
#If SERVER_IP is 0.0.0.0, assign public IP address to REAL_IP.
SERVER_IP=$(ip a | grep glo | awk '{print $2}' | head -1 | cut -f1 -d/)
SUBDOMAIN=$(cat /var/plexguide/server.domain)
PAS_CONFIG="/opt/appdata/pgscan/config/config.json"

    SERVER_IP=$(cat ${PAS_CONFIG} | jq -r .SERVER_IP)
    SERVER_PORT=$(cat ${PAS_CONFIG} | jq -r .SERVER_PORT)
    SERVER_PASS=$(cat ${PAS_CONFIG} | jq -r .SERVER_PASS)
	
    if (( SIMPLE - 1 )); then
        echo "Your Plex Autoscan URL:"
        echo "http://${SUBDOMAIN}:${SERVER_PORT}/${SERVER_PASS}"
        echo ""
    else
        echo http://${SUBDOMAIN}:${SERVER_PORT}/${SERVER_PASS}
    fi
}

# FIRST QUESTION
question1() {

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Scan Interface
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Deploy Scan                     [$dstatus]

[2] PlexAutoScan Domain 

[Z] - Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  if [ "$typed" == "1" ]; then
    ansible-playbook /opt/plexguide/menu/pgscan/pgscan.yml && question1
  elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then
    exit
  else badinput; fi
}
showupdomain() {

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Scan Interface
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

 [ $showupdomain ]

[Z] - Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  if [ "$typed" != "Z" ]; then
    question1
  elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then
    exit
  else badinput; fi
}

# FUNCTIONS END ##############################################################
plexcheck
token
deploycheck
question1
