# KEY VARIABLE RECALL & EXECUTION
source /opt/plexguide/menu/pgscan/scripts/endbanner.sh
mkdir -p /var/plexguide/pgscan
touch /var/plexguide/pgscan/plex.token
variable /var/plexguide/pgscan/fixmatch.lang "en"
variable /var/plexguide/pgscan/fixmatch.status "false"
# FUNCTIONS START ##############################################################
# FIRST FUNCTION
variable() {
  file="$1"
  if [[ ! -e "$file" ]]; then echo "$2" >$1; fi
}

passtartfirst() {
file="/opt/plex_autoscan/config/config.json"
  if [[ ! -f $file ]]; then
	pasundeployed 
  else plexcheck; fi
}

deploycheck() {
  dcheck=$(systemctl is-active plex_autoscan.service)
  if [[ "$dcheck" == "active" ]]; then
    dstatus="✅ DEPLOYED"
  else dstatus="⚠️ NOT DEPLOYED"; fi
}

tokenstatus() {
  ptokendep=$(cat /var/plexguide/pgscan/plex.token)
  if [[ "$ptokendep" != "" ]]; then
        if [[ ! -f "/opt/plex_autoscan/config/config.json" ]]; then
                pstatus="❌ DEPLOYED BUT PAS CONFIG MISSING";
        else
                PGSELFTEST=$(curl -LI "http://$(hostname -I | awk '{print $1}'):32400/system?X-Plex-Token=$(cat /opt/plex_autoscan/config/config.json | jq .PLEX_TOKEN | sed 's/"//g')" -o /dev/null -w '%{http_code}\n' -s)
                if [[ $PGSELFTEST -ge 200 && $PGSELFTEST -le 299 ]]; then  pstatus="✅ DEPLOYED"
                else pstatus="❌ DEPLOYED BUT PAS TOKEN FAILED"; fi
        fi
  else pstatus="⚠️ NOT DEPLOYED"; fi
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
  touch /var/plexguide/pgscan/plex.token
  ptoken=$(cat /var/plexguide/pgscan/plex.token)
  if [[ "$ptoken" == "" ]]; then
    tokencreate
	sleep 2
	X_PLEX_TOKEN=$(sudo cat "/opt/appdata/plex/database/Library/Application Support/Plex Media Server/Preferences.xml" | sed -e 's;^.* PlexOnlineToken=";;' | sed -e 's;".*$;;' | tail -1)
    ptoken=$(cat /var/plexguide/pgscan/plex.token)
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
templatebackup=/opt/plexguide/menu/roles/plex_autoscan/templates/config.backup
template=/opt/plexguide/menu/roles/plex_autoscan/templates/config.json.j2
X_PLEX_TOKEN=$(sudo cat "/opt/appdata/plex/database/Library/Application Support/Plex Media Server/Preferences.xml" | sed -e 's;^.* PlexOnlineToken=";;' | sed -e 's;".*$;;' | tail -1)

cp -r $template $templatebackup
echo $X_PLEX_TOKEN >/var/plexguide/pgscan/plex.token

RAN=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
echo $RAN >/var/plexguide/pgscan/pgscan.serverpass
}

# BAD INPUT
badinput() {
  echo
  read -p '⛔️ ERROR - BAD INPUT! | PRESS [ENTER] ' typed </dev/tty
  clear && question1
}

dontwork() {
 echo
  read -p 'Confirm Info | PRESS [ENTER] ' typed </dev/tty
  clear &&  exit 0
}

works(){
 echo
  read -p 'Confirm Info | PRESS [ENTER] ' typed </dev/tty
  clear && question1
}
credits(){
clear
chk=$(figlet Plex Auto Scan | lolcat )
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Plex_AutoScan Credits 
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

$chk

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
  clear && question1
}

doneenter(){
 echo
  read -p 'All done | PRESS [ENTER] ' typed </dev/tty
  clear && question1
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
 works
}
remove(){
ansible-playbook /opt/plexguide/menu/pgscan/remove-pgscan.yml 
  printf '
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Plex_AutoScan is full removed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
'
 echo 
  read -p 'All done | PRESS [ENTER] ' typed </dev/tty
}
fxmatch() {
  tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Plex_AutoScan FixMatching 
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NOTE : 
Plex Autoscan will compare the TVDBID/TMDBID/IMDBID sent 
by Sonarr/Radarr with what Plex has matched with, and if 
this match is incorrect, it will autocorrect the match on the 
item (movie file or TV episode). If the incorrect match is 
a duplicate entry in Plex, it will auto split the original 
entry before correcting the match on the new item.


[1] Fixmatch Lang                     [ $(cat /var/plexguide/pgscan/fixmatch.lang) ]
[2] Fixmatch on / off                 [ $(cat /var/plexguide/pgscan/fixmatch.status) ]

[Z] - Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1) lang && clear && fxmatch ;;
  2) runs && clear && fxmatch ;;
  z) question1 ;;
  Z) question1 ;;
  *) fxmatch ;;
  esac

}
lang() {
  tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Plex_AutoScan FixMatching  Lang
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NOTE : Sample :

this will work : 
en
de 
jp
ch

Default is "en"

[Z] - Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p '↘️  Type Lang | Press [ENTER]: ' typed </dev/tty

  if [[ "$typed" == "exit" || "$typed" == "Exit" || "$typed" == "EXIT" || "$typed" == "z" || "$typed" == "Z" ]]; then
  fxmatch 
  else
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ SYSTEM MESSAGE:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Language Set Is: $typed

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  echo $typed >/var/plexguide/pgscan/fixmatch.lang
    read -p '🌎 Acknowledge Info | Press [ENTER] ' typed </dev/tty
  fxmatch
  fi
}
runs() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Plex_AutoScan Fixmissmatch
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] True 
[2] False

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[Z] - Exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1) echo "true" >/var/plexguide/pgscan/fixmatch.status && fxmatch ;;
  2) echo "false" >/var/plexguide/pgscan/fixmatch.status && fxmatch ;;
  z) fxmatch ;;
  Z) fxmatch ;;
  *) fxmatch ;;
  esac
}
#######################################################################################
question1() {
langfa=$(cat /var/plexguide/pgscan/fixmatch.status)
lang=$(cat at /var/plexguide/pgscan/fixmatch.lang)
tokenstatus
deploycheck
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Plex_AutoScan Interface  || l3uddz/plex_autoscan
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE : Plex_AutoScan are located in /opt/plex_autoscan

[1] Deploy Plex Token                     [ $pstatus ]
[2] Fixmatch Lang                         [ $lang | $langfa ]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[A] Deploy Plex-Auto-Scan                 [ $dstatus ]

[D] PlexAutoScan Domain
[S] Show last 50 lines of Plex_AutoScan log
[R] Remove Plex_AutoScan
[C] Credits

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Z] - Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1) tokencreate && clear && question1 ;;
  2) fxmatch && clear && question1 ;;
  A) ansible-playbook /opt/plexguide/menu/pg.yml --tags plex_autoscan && clear && pasdeployed && question1 ;;
  a) ansible-playbook /opt/plexguide/menu/pg.yml --tags plex_autoscan && clear && pasdeployed && question1 ;;
  D) showupdomain && clear && question1 ;;
  d) showupdomain && clear && question1 ;;
  S) tail -n 50 /opt/plex_autoscan/plex_autoscan.log && doneenter ;;
  s) tail -n 50 /opt/plex_autoscan/plex_autoscan.log && doneenter;;
  r) remove && doneenter  && sleep 5 && clear && exit 0 ;;
  R) remove && doneenter && sleep 5 && clear && exit 0 ;;
  C) credits && clear && question1 ;;
  c) credits && clear && question1 ;;
  z) exit 0 ;;
  Z) exit 0 ;;
  *) question1 ;;
  esac
}
# FUNCTIONS END ##############################################################
passtartfirst
tokenstatus
deploycheck
question1
