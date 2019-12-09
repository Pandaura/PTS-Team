#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
touch /var/plexguide/plex.updaterole
touch /var/plexguide/plex.server
touch /var/plexguide/plex.claim
# FUNCTIONS START ##############################################################

# BAD INPUT
badinput() {
  echo
  read -p '⛔️ ERROR - BAD INPUT! | PRESS [ENTER] ' typed </dev/tty
}

strart0 () {
local=(cat /var/plexguide/pg.transport)
if [ $local == "Local" ]; then
 localpart
  else remotepart; fi
}

localpart() {
setserver && updateplex
}

remotepart() {
setserver && claim && updateplex
}
 
# FUNCTIONS END  #############################################################

# SETVALUE START #############################################################
setserver() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  PLEX Installer
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NOTE: DO NOT SELECT LOCAL SYSTEM for a REMOTE SERVER outside of your
network as in using Hetzner, WholeSale Internet & Etc! 
If you do it , it will not work and you will have to reinstall PLEX!

[1] Plex Remote System ~ OUTSIDE your LOCAL NETWORK (i.e 3rd Party)

[2] Plex Local System  ~ INSIDE  your LOCAL NETWORK (i.e Home)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1) echo "remote" >/var/plexguide/plex.server ;;
  2) echo "local" >/var/plexguide/plex.server ;;
  *) badinput && setserver ;;
  esac
}

# THIRD QUESTION
claim() {
  tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 Remote Plex Server - Claim the Plex Server
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

To Claim the Plex Server, visit https://www.plex.tv/claim/ and input the
code below! You have 5 minutes to do so!

If you are reinstalling plex with existing appdata press enter to skip 
this step as you won't need to claim it again.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p 'Plex Server Claim Number | Press [ENTER]: ' typed </dev/tty
  echo $typed >/var/plexguide/plex.claim 
	  if [ $(cat /var/plexguide/image/plex) == linuxserver/plex ];then
		bash /opt/plexguide/menu/plex/lsio-plex-claim.sh $(cat /var/plexguide/plex.claim) 
	  fi
}

updateplex() {
touch /var/plexguide/plex.updaterole
pupdat=$(cat /var/plexguide/plex.updaterole)
if [ $pupdat == $pupdat ]; then
exit 
else 
  tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 Update Plex Server Edition
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[ 1 ] docker: 
Let Docker handle the Plex Version, we keep our 
Dockerhub Endpoint up to date with the latest public builds. 
This is the same as leaving this setting out of your create command.

[ 2 ] latest: 
will update plex to the latest 
version available that you are entitled to.

[ 3 ] public: 
will update plexpass users to the latest public version, 
useful for plexpass users that don't want to 
be on the bleeding edge but still want the latest public updates.
´
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1) echo "docker" >/var/plexguide/plex.updaterole ;;
  2) echo "latest" >/var/plexguide/plex.updaterole ;;
  3) echo "public" >/var/plexguide/plex.updaterole ;;
  *) badinput && updateplex ;;
  esac
}

# SETVALUE END ##############################################################

start0


#ansible-playbook /opt/coreapps/apps/plex.yml
