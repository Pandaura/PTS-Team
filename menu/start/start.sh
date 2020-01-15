#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
# Create Variables (If New) & Recall
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
  ###################### FOR VARIABLS ROLE SO DOESNT CREATE RED - START
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

  ###################### FOR VARIABLS ROLE SO DOESNT CREATE RED - START
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
    echo "Open" >$filevg/pg.ports
  else echo "Closed" >$filevg/pg.ports; fi

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

menuprime1() {
  transport=$(cat /var/plexguide/pg.transport)

  # Menu Interface
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 $transport | Version: $pgnumber | ID: $serverid
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🌵 Disk Used Space: $used of $capacity | $percentage Used Capacity
EOF

  # Displays Second Drive If GCE
  edition=$(cat /var/plexguide/pg.server.deploy)
  if [ "$edition" == "feeder" ]; then
    used_gce=$(df -h /mnt --local | tail -n +2 | awk '{print $3}')
    capacity_gce=$(df -h /mnt --local | tail -n +2 | awk '{print $2}')
    percentage_gce=$(df -h /mnt --local | tail -n +2 | awk '{print $5}')
    echo " GCE Disk Used Space: $used_gce of $capacity_gce | $percentage_gce Used Capacity"
  fi

  disktwo=$(cat "/var/plexguide/server.hd.path")
  if [ "$edition" != "feeder" ]; then
    used_gce2=$(df -h "$disktwo" --local | tail -n +2 | awk '{print $3}')
    capacity_gce2=$(df -h "$disktwo" --local | tail -n +2 | awk '{print $2}')
    percentage_gce2=$(df -h "$disktwo" --local | tail -n +2 | awk '{print $5}')

    if [[ "$disktwo" != "/mnt" ]]; then
      echo " 2nd Disk Used Space: $used_gce2 of $capacity_gce2 | $percentage_gce2 Used Capacity"
    fi
  fi

  # Declare Ports State
  ports=$(cat /var/plexguide/server.ports)

  if [ "$ports" == "" ]; then
    ports="OPEN"
  else ports="CLOSED"; fi

  tee <<-EOF
     -- GCE optimized surface --

[1]  PTS-Traefik    : Reverse Proxy
[2]  Port Guard     : [$ports] Protects the Server App Ports
[3]  PTS-Shield     : Enable Google's OAuthentication Protection
[4]  PTS-Clone      : Mount Transport
[5]  PTS-Apps       : Apps
[6]  PTS-Vault      : Backup & Restore
[7]  Traktarr       : Fill Sonarr/Radarr over Trakt lists.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Z]  Exit

"$wisword"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  # Standby
  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1) clear && bash /opt/plexguide/menu/pgcloner/traefik.sh && clear && primestart ;;
  2) clear && bash /opt/plexguide/menu/portguard/portguard.sh && clear && primestart ;;
  3) clear && bash /opt/plexguide/menu/shield/pgshield.sh && clear && primestart ;;
  4) clear && bash /opt/plexguide/menu/pgcloner/pgclone.sh && clear && primestart ;;
  5) clear && bash /opt/plexguide/menu/pgbox/select.sh  && clear && primestart ;;
  6) clear && bash /opt/plexguide/menu/pgcloner/pgvault.sh  && clear && primestart ;;
  7) clear && bash /opt/plexguide/menu/traktarr/traktarr.sh  && clear && primestart ;;
  z) clear && bash /opt/plexguide/menu/interface/ending.sh &&  exit ;;
  Z) clear && bash /opt/plexguide/menu/interface/ending.sh && exit ;;
  *) primestart ;;
  esac
}

menuprime2() {
  transport=$(cat /var/plexguide/pg.transport)

  # Menu Interface
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 $transport | Version: $pgnumber | ID: $serverid
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🌵 Disk Used Space: $used of $capacity | $percentage Used Capacity
EOF

  # Displays Second Drive If GCE
  edition=$(cat /var/plexguide/pg.server.deploy)
  if [ "$edition" == "feeder" ]; then
    used_gce=$(df -h /mnt --local | tail -n +2 | awk '{print $3}')
    capacity_gce=$(df -h /mnt --local | tail -n +2 | awk '{print $2}')
    percentage_gce=$(df -h /mnt --local | tail -n +2 | awk '{print $5}')
    echo " GCE Disk Used Space: $used_gce of $capacity_gce | $percentage_gce Used Capacity"
  fi

  disktwo=$(cat "/var/plexguide/server.hd.path")
  if [ "$edition" != "feeder" ]; then
    used_gce2=$(df -h "$disktwo" --local | tail -n +2 | awk '{print $3}')
    capacity_gce2=$(df -h "$disktwo" --local | tail -n +2 | awk '{print $2}')
    percentage_gce2=$(df -h "$disktwo" --local | tail -n +2 | awk '{print $5}')

    if [[ "$disktwo" != "/mnt" ]]; then
      echo " 2nd Disk Used Space: $used_gce2 of $capacity_gce2 | $percentage_gce2 Used Capacity"
    fi
  fi

  # Declare Ports State
  ports=$(cat /var/plexguide/server.ports)

  if [ "$ports" == "" ]; then
    ports="OPEN"
  else ports="CLOSED"; fi

  tee <<-EOF

[1]  PTS-Traefik    : Reverse Proxy
[2]  Port Guard     : [$ports] Protects the Server App Ports
[3]  PTS-Shield     : Enable Google's OAuthentication Protection
[4]  PTS-Clone      : Mount Transport
[5]  PTS-Apps       : Apps ~ Core, Community & Removal
[6]  CBOX-PAS       : PlexAutoScan 
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[7]  PTS-WordPress  : Deploy WordPress Instances
[8]  PTS-Vault      : Backup & Restore
[9]  PTS-Cloud      : GCE & Virtual Instances
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[10] CBOX-PDUPE     : Find and delete duplicate files in Plex
[11] Traktarr       : Fill Sonarr/Radarr over Trakt lists.
[12] Plex Patrol    : Kick transcodes (audio or video or both)
[13] Settings 
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[Z]  Exit

"$wisword"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  # Standby
  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1) clear && bash /opt/plexguide/menu/pgcloner/traefik.sh && clear && primestart ;;
  2) clear && bash /opt/plexguide/menu/portguard/portguard.sh && clear && primestart ;;
  3) clear && bash /opt/plexguide/menu/shield/pgshield.sh && clear && primestart ;;
  4) clear && bash /opt/plexguide/menu/pgcloner/pgclone.sh && clear && primestart ;;
  5) clear && bash /opt/plexguide/menu/pgbox/select.sh && clear && primestart ;;
  6) clear && bash /opt/plexguide/menu/pgscan/pgscan.sh && clear && primestart ;;
  7) clear && bash /opt/plexguide/menu/pgcloner/pgpress.sh && clear && primestart ;;
  8) clear && bash /opt/plexguide/menu/pgcloner/pgvault.sh && clear && primestart ;;
  9) clear && bash /opt/plexguide/menu/interface/cloudselect.sh && clear && primestart ;;
  10) clear && bash /opt/plexguide/menu/plex_dupe/plex_dupe.sh && clear && primestart ;;
  11) clear && bash /opt/plexguide/menu/traktarr/traktarr.sh && clear && primestart ;;
  12) clear && bash /opt/plexguide/menu/plexpatrol/plexpatrol.sh && clear && primestart ;;
  13) clear && bash /opt/plexguide/menu/interface/settings.sh && clear && primestart ;;
  z) clear && bash /opt/plexguide/menu/interface/ending.sh  && exit ;;
  Z) clear&& bash /opt/plexguide/menu/interface/ending.sh && exit ;;
  *) primestart ;;
  esac
}

primestart
