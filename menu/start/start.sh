#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
file="/var/plexguide/pg.number"
if [ -e "$file" ]; then
  check="$(cat /var/plexguide/pg.number | head -c 1)"
  if [[ "$check" == "5" || "$check" == "6" || "$check" == "7" ]]; then
    exit
  fi
fi

# Create Variables (If New) & Recall
pcloadletter() {
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
  menuprime
}

# When Called, A Quoate is Randomly Selected
quoteselect() {
  bash /opt/plexguide/menu/start/quotes.sh
  quote=$(cat /var/plexguide/startup.quote)
  source=$(cat /var/plexguide/startup.source)
}

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
  filevg="/var/plexguide"
  ###################### FOR VARIABLS ROLE SO DOESNT CREATE RED - START
  variable $filevg/pgfork.project "NOT-SET"
  variable $filevg/pgfork.version "NOT-SET"
  variable $filevg/tld.program "NOT-SET"
  variable /opt/appdata/plexguide/plextoken "NOT-SET"
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
  echo "export NCURSES_NO_UTF8_ACS=1" >>/etc/bash.bashrc.local

  # run pg main
  file="/var/plexguide/update.failed"
  if [ -e "$file" ]; then
    rm -rf $filevg/update.failed
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
  
  ## stupid line cat /etc/os-release | head -n +5 | tail -n +5 | cut -d'"' -f2 >/var/plexguide/pg.os

  file="/var/plexguide/gce.false"
  if [ -e "$file" ]; then echo "No" >$filevg/pg.gce; else echo "Yes" >$filevg/pg.gce; fi

  # Call Variables
  edition=$(cat /var/plexguide/pg.edition)
  serverid=$(cat /var/plexguide/server.id)
  pgnumber=$(cat /var/plexguide/pg.number)

  # Declare Traefik Deployed Docker State
  if [[ $(docker ps | grep "traefik") == "" ]]; then
    traefik="NOT DEPLOYED"
    echo "Not Deployed" >$filevg/pg.traefik
  else
    traefik="DEPLOYED"
    echo "Deployed" >$filevg/pg.traefik
  fi

  if [[ $(docker ps | grep "oauth") == "" ]]; then
    traefik="NOT DEPLOYED"
    echo "Not Deployed" >$filevg/pg.auth
  else
    traefik="DEPLOYED"
    echo "Deployed" >$filevg/pg.oauth
  fi

  # For ZipLocations
  file="/var/plexguide/data.location"
  if [ ! -e "$file" ]; then echo "/opt/appdata/plexguide" >$filevg/data.location; fi

  space=$(cat /var/plexguide/data.location)
  used=$(df -h /opt/ | tail -n +2 | awk '{print $3}')
  capacity=$(df -h /opt/ | tail -n +2 | awk '{print $4}')
  percentage=$(df -h /opt/ | tail -n +2 | awk '{print $5}')

  # For the PGBlitz UI
  echo "$used" >/var/plexguide/pg.used
  echo "$capacity" >/var/plexguide/pg.capacity
}

menuprime() {
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

  quoteselect

  tee <<-EOF

[1]  Traefik    : Reverse Proxy
[2]  Port Guard : [$ports] Protects the Server Ports
[3]  GOAuth     : Enable Google's OAuthentication Protection
[4]  rClone     : Mount Transport
[5]  APPBox     : Apps ~ Core, Community & Removal
[6]  WordPress  : Deploy WordPress Instances
[7]  Back&Rest  : Backup & Restore
[8]  Cloud      : GCE & Virtual Instances
[9]  Tools
[10] Settings
[Z]  Exit

"$quote"

$source
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  # Standby
  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1)
    bash /opt/plexguide/menu/pgcloner/traefik.sh
    primestart
    ;;
  2)
    bash /opt/plexguide/menu/portguard/portguard.sh
    primestart
    ;;
  3)
    bash /opt/plexguide/menu/pgcloner/pgshield.sh
    primestart
    ;;
  4)
    bash /opt/plexguide/menu/pgcloner/pgclone.sh
    primestart
    ;;
  5)
    bash /opt/plexguide/menu/pgbox/pgboxselect.sh
    primestart
    ;;
  6)
    bash /opt/plexguide/menu/pgcloner/pgpress.sh
    primestart
    ;;
  7)
    bash /opt/plexguide/menu/pgcloner/pgvault.sh
    primestart
    ;;
  8)
    bash /opt/plexguide/menu/interface/cloudselect.sh
    primestart
    ;;
  9)
    bash /opt/plexguide/menu/tools/tools.sh
    primestart
    ;;
  10)
    bash /opt/plexguide/menu/interface/settings.sh
    primestart
    ;;
  z)
    bash /opt/plexguide/menu/interface/ending.sh
    exit
    ;;
  Z)
    bash /opt/plexguide/menu/interface/ending.sh
    exit
    ;;
  *)
    primestart
    ;;
  esac
}

primestart
