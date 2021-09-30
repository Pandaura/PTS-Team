#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
# Create Variables (If New) & Recall
source /opt/plexguide/menu/functions/start.sh
source /opt/plexguide/menu/functions/pgvault.func
source /opt/plexguide/menu/pgvault/pgvault.sh
typed="${typed,,}"

pcloadletter() {
  filevg="/var/plexguide"
  touch $filevg/pgclone.transport
  temp=$(cat /var/plexguide/pgclone.transport)
  if [ "$temp" == "mu" ]; then
    transport="Move"
  elif [ "$temp" == "me" ]; then
    transport="Move: Encrypted"
  elif [ "$temp" == "bu" ]; then
    transport="Blitz"
  elif [ "$temp" == "be" ]; then
    transport="Blitz: Encrypted"
  elif [ "$temp" == "le" ]; then
    transport="Local"
  else transport="NOT-SET"; fi
  echo "$transport" >$filevg/pg.transport
}

variable() {
  file="$1"
  if [ ! -e "$file" ]; then echo "$2" >$1; fi
}

# What Loads the Order of Execution
primestart() {
  pcloadletter
  varstart
  gcetest
}

wisword=$(/usr/games/fortune -as | sed "s/^/ /")

varstart() {
  ###################### FOR VARIABLES ROLE SO DOESNT CREATE RED - START
  filevg="/var/plexguide"
  if [ ! -e "$filevg" ]; then
    mkdir -p $filevg/logs 1>/dev/null 2>&1
    chown -R 1000:1000 $file 1>/dev/null 2>&1
    chmod -R 775 $file 1>/dev/null 2>&1
  fi
  fileag="/opt/appdata/plexguide"
  if [ ! -e "$fileag" ]; then
    mkdir -p $fileag 1>/dev/null 2>&1
    chown -R 1000:1000 $fileag 1>/dev/null 2>&1
    chmod -R 775 $fileag 1>/dev/null 2>&1
  fi

  ###################### FOR VARIABLES ROLE SO DOESNT CREATE RED - START
  variable $filevg/pgfork.project "NOT-SET"
  variable $filevg/pgfork.version "NOT-SET"
  variable $filevg/tld.program "NOT-SET"
  variable $fileag/plextoken "NOT-SET"
  variable $filevg/server.ht ""
  variable $filevg/server.ports "127.0.0.1:"
  variable $filevg/server.email "NOT-SET"
  variable $filevg/server.domain "NOT-SET"
  variable $filevg/tld.type "standard"
  variable $filevg/transcode.path "standard"
  variable $filevg/pgclone.transport "NOT-SET"
  variable $filevg/plex.claim ""
  
  #### Temp Fix - Fixes Bugged AppGuard
  serverht=$(cat /var/plexguide/server.ht)
  if [ "$serverht" == "NOT-SET" ]; then
    rm $filevg/server.ht
    touch $filevg/server.ht
  fi

  hostname -I | awk '{print $1}' >$filevg/server.ip
  ###################### FOR VARIABLS ROLE SO DOESNT CREATE RED - END
  value="/etc/bash.bashrc.local"
  rm -rf $value && echo -e "export NCURSES_NO_UTF8_ACS=1" >>$value

  # run pg main
  file="/var/plexguide/update.failed"
  if [ -e "$file" ]; then
    rm -rf /var/plexguide/update.failed
    exit
  fi
  #################################################################################

  # Touch Variables Incase They Do Not Exist
  touch $filevg/pg.edition
  touch $filevg/server.id
  touch $filevg/pg.number
  touch $filevg/traefik.deployed
  touch $filevg/server.ht
  touch $filevg/server.ports
  touch $filevg/pg.server.deploy

  # For PG UI - Force Variable to Set
  ports=$(cat /var/plexguide/server.ports)
  if [ "$ports" == "" ]; then
    echo "🔴" >$filevg/pg.ports
  else echo "🟢" >$filevg/pg.ports; fi

  ansible --version | head -n +1 | awk '{print $2'} >$filevg/pg.ansible
  docker --version | head -n +1 | awk '{print $3'} | sed 's/,$//' >$filevg/pg.docker
  lsb_release -si >$filevg/pg.os
  
  file="/var/plexguide/gce.false"
  if [ -e "$file" ]; then echo "No" >$filevg/pg.gce; else echo "Yes" >$filevg/pg.gce; fi

  # Call Variables
  edition=$(cat /var/plexguide/pg.edition)
  serverid=$(cat /var/plexguide/server.id)
  pgnumber=$(cat /var/plexguide/pg.number)

  # Declare Traefik Deployed Docker State
  if [[ $(docker ps --format {{.Names}}| grep "traefik") != "traefik" ]]; then
    traefik="NOT DEPLOYED"
    echo "Not Deployed" >$filevg/pg.traefik
  else
    traefik="DEPLOYED"
    echo "Deployed" >$filevg/pg.traefik
  fi

  if [[ $(docker ps --format {{.Names}}| grep "oauth") != "oauth" ]]; then
    oauth="NOT DEPLOYED"
    echo "Not Deployed" >$filevg/pg.auth
  else
    oauth="DEPLOYED"
    echo "Deployed" >$filevg/pg.oauth
  fi

  # For ZipLocations
  file="/var/plexguide/data.location"
  if [ ! -e "$file" ]; then echo "/opt/appdata/plexguide" >$filevg/data.location; fi

  space=$(cat /var/plexguide/data.location)
  used=$(df -h / --local | tail -n +2 | awk '{print $3}' )
  capacity=$(df -h / --local  | tail -n +2 | awk '{print $2}')
  percentage=$(df -h / --local | tail -n +2 | awk '{print $5}')

  # For the PGBlitz UI
  echo "$used" >$filevg/pg.used
  echo "$capacity" >$filevg/pg.capacity
}

gcetest(){
gce=$(cat /var/plexguide/pg.server.deploy)

if [[ $gce == "feeder" ]]; then
menuprime1
else menuprime2; fi
}

menuprime1() { # GCE Optimised Menu
transport=$(cat /var/plexguide/pg.transport)
top_menu
disk_space_used_space

  # Declare Ports State
  ports=$(cat /var/plexguide/server.ports)

  if [ "$ports" == "" ]; then
    ports="🔴"
  else ports="🟢"; fi

  tee <<-EOF
     -- GCE optimized surface --

[1]  Traefik        : Reverse Proxy | Domain Setup
[2]  Port Guard     : [$ports] Protects the Server App Ports
[3]  Authelia       : Enable Authelia
[4]  Mount          : Mount Cloud Based Storage
[5]  Apps           : Apps ~ Core, Community & Removal
[6]  Vault          : Backup & Restore
[7]  Traktarr       : Fill arr's with Trakt lists
EOF
end_menu
  # Standby
  read -p '💬  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1) clear && bash /opt/plexguide/menu/pgcloner/traefik.sh && clear && primestart ;;
  2) clear && bash /opt/plexguide/menu/portguard/portguard.sh && clear && primestart ;;
  3) clear && bash /opt/plexguide/menu/shield/pgshield.sh && clear && primestart ;;
  4) clear && bash /opt/plexguide/menu/pgcloner/pgclone.sh && clear && primestart ;;
  5) clear && bash /opt/plexguide/menu/pgbox/select.sh  && clear && primestart ;;
  6) clear && bash /opt/plexguide/menu/pgvault/pgvault.sh  && clear && primestart ;;
  7) clear && bash /opt/plexguide/menu/traktarr/traktarr.sh  && clear && primestart ;;
  z) clear && bash /opt/plexguide/menu/interface/ending.sh &&  exit ;;
  Z) clear && bash /opt/plexguide/menu/interface/ending.sh && exit ;;
  *) primestart ;;
  esac
}
networking() {
  top_menu
  sub_menu_networking
  end_menu
read -p '💬  Type Number | Press [ENTER]: ' typed </dev/tty
    if [[ "${typed}" == "e" ]]; then clear && bash /opt/plexguide/menu/pgcloner/traefik.sh; fi
    if [[ "${typed}" == "exit" || "${typed}" == "z" ]]; then exit; fi
    main_menu_options

}
security() {
  top_menu
  sub_menu_security
  end_menu
  read -p '💬  Type Number | Press [ENTER]: ' typed </dev/tty
   if [[ "${typed}" == "e" ]]; then clear && mount /opt/plexguide/menu/shield/pgshield.sh; fi
   if [[ "${typed}" == "d" ]]; then clear && bash /opt/plexguide/menu/portguard/portguard.sh; fi
   if [[ "${typed}" == "c" ]]; then clear && bash /opt/plexguide/menu/pgbox/core/core.sh; fi
   if [[ "${typed}" == "exit" || "${typed}" == "z" ]]; then exit; fi
   main_menu_options
}

mount() {
  top_menu
  sub_menu_mount
  end_menu
  read -p '💬  Type Number | Press [ENTER]: ' typed </dev/tty
   if [[ "${typed}" == "e" ]]; then clear && bash /opt/plexguide/menu/pgcloner/pgclone.sh && clear && primestart; fi
   if [[ "${typed}" == "e" ]]; then clear && bash /opt/plexguide/menu/portguard/portguard.sh; fi
   if [[ "${typed}" == "e" ]]; then clear && bash /opt/plexguide/menu/pgbox/core/core.sh; fi
   if [[ "${typed}" == "exit" || "${typed}" == "z" ]]; then exit; fi
   main_menu_options
}
apps() {
  top_menu
  sub_menu_app
  end_menu
  read -p '💬  Type Number | Press [ENTER]: ' typed </dev/tty
    if [[ "${typed}" == "e" ]]; then clear && bash /opt/plexguide/menu/pgbox/core/core.sh; fi
    if [[ "${typed}" == "d" ]]; then clear && bash /opt/plexguide/menu/pgbox/community/community.sh; fi
    if [[ "${typed}" == "c" ]]; then clear && bash /opt/plexguide/menu/pgbox/personal/personal.sh; fi
    if [[ "${typed}" == "r" ]]; then clear && bash /opt/plexguide/menu/pgbox/remove/removal.sh; fi
    if [[ "${typed}" == "f" ]]; then clear && bash /opt/plexguide/menu/pgbox/remove/removal.sh; fi
    if [[ "${typed}" == "t" ]]; then clear && bash /opt/plexguide/menu/pgbox/customparts/autobackup.sh; fi
    if [[ "${typed}" == "exit" || "${typed}" == "z" ]]; then exit; fi
    main_menu_options
}
vault() {
  top_menu
  sub_menu_vault
  end_menu
  read -p '💬  Type Number | Press [ENTER]: ' typed </dev/tty
    if [[ "${typed}" == "e" ]]; then clear && initial && pgboxrecall && apprecall && vaultbackup; fi
    if [[ "${typed}" == "d" ]]; then clear && backup_all_start; fi
    if [[ "${typed}" == "c" ]]; then clear && initial && pgboxrecall && apprecall && vaultrestore; fi
    if [[ "${typed}" == "r" ]]; then clear && restore_all_start; fi
    if [[ "${typed}" == "f" ]]; then clear && bash /opt/plexguide/menu/pgvault/location.sh; fi
    if [[ "${typed}" == "exit" || "${typed}" == "z" ]]; then exit; fi
    main_menu_options
}
menuprime2() { # 
  #welcome="Welcome to Pandaura. Thanks for being a part of the community"
  #firstRun=True
#def writeFile(number):
 #   global firstRun
  #  if firstRun:
   #     print("${welcome}")
    #    firstRun=False
    #print(str(number))

#for i in range(10):
 #   writeFile(i)
  transport=$(cat /var/plexguide/pg.transport)
top_menu
disk_space_used_space
main_menu
  # Declare Ports State
  ports=$(cat /var/plexguide/server.ports)

  if [ "$ports" == "" ]; then
    ports="🔴 "
  else ports="🟢"; fi

#if [[ "${typed}" == "2" ]]; then sub_menu_security; fi
end_menu
  # Standby
  read -p '💬  Type Number | Press [ENTER]: ' typed </dev/tty


  

Used disk space: $used of $capacity | $percentage used capacity                  Deployed
EOF
main_menu_options() {
  case $typed in
  1) clear && networking;;
  2) clear && security && clear && primestart;;
  3) clear && mount && clear && primestart;;
  4) clear && apps && clear && primestart;;
  5) clear && vault && clear && primestart;;
  esac
}
  case $typed in
  1) clear && networking && clear && primestart ;;
  2) clear && security && clear && primestart ;;
  3) clear && mount && clear && primestart;;
  4) clear && apps && clear && primestart;;
  5) clear && vault && clear && primestart;;
  #/opt/plexguide/menu/pgscan/pgscan.sh && clear && primestart ;;
  7) clear && bash /opt/plexguide/menu/pgvault/pgvault.sh && clear && primestart ;;
  8) clear && bash /opt/plexguide/menu/plex_dupe/plex_dupe.sh && clear && primestart ;;
  9) clear && bash /opt/plexguide/menu/traktarr/traktarr.sh && clear && primestart ;;
  10) clear && bash /opt/plexguide/menu/plexpatrol/plexpatrol.sh && clear && primestart ;;
  0) clear && bash /opt/plexguide/menu/interface/settings.sh && clear && primestart ;;
  z) clear && bash /opt/plexguide/menu/interface/ending.sh  && exit ;;
  Z) clear&& bash /opt/plexguide/menu/interface/ending.sh && exit ;;
  *) primestart ;;
  #These options are hidden
  13) clear && bash /opt/plexguide/menu/interface/cloudselect.sh && clear && primestart ;;
  12) clear && bash /opt/plexguide/menu/pgcloner/pgpress.sh && clear && primestart ;;
  esac
}
#bash /opt/plexguide/menu/pgbox/select.sh && clear && primestart ;; this is for apps
primestart
