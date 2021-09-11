#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
typed="${typed,,}"
program=$(cat /tmp/program_var)
cname=$program

if [[ -f "/var/plexguide/$program.cname" ]]; then
    cname=$(cat /var/plexguide/$program.cname)
fi

domain=$(cat /var/plexguide/server.domain)
port=$(cat /tmp/program_port)
ip=$(cat /var/plexguide/server.ip)
ports=$(cat /var/plexguide/server.ports)
hdpath=$(cat /var/plexguide/server.hd.path)



if [ "$program" == "plex" ]; then extra="/web"; else extra=""; fi

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🛈 Access Configuration Info
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

tee <<-EOF
▫ $program:${port} <- Use this as the url when connecting another app to $program.
EOF

if [ "$ports" == "" ]; then
  tee <<-EOF
▫ $ip:${port}${extra}
EOF
fi

if [ "$domain" != "NOT-SET" ]; then
    if [ "$ports" == "" ]; then
    tee <<-EOF
▫ $domain:${port}${extra}
EOF
    fi
  tee <<-EOF
▫ $cname.$domain${extra}
EOF
fi

if [ "$program" == "plex" ]; then
  tee <<-EOF

First Time Plex Claim Notice
━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    if [ "$domain" != "NOT-SET" ]; then
    tee <<-EOF
▫ http://plex.${domain}:32400 <-- Use http; not https
EOF
    fi
    
  tee <<-EOF
▫ $ip:${port}${extra}
EOF
fi

if [[ "$program" == *"sonarr"* ]] || [[ "$program" == *"radarr"* ]] || [[ "$program" == *"lidarr"* ]]; then
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💬 Manual Configuration Required
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  $program requires additional manual configuration!
EOF
    if [[ "$program" == *"sonarr"* ]] || [[ "$program" == *"radarr"* ]] || [[ "$program" == *"lidarr"* ]] || [[ "$program" == *"qbittorrent"* ]]; then
    tee <<-EOF

  $program requires "downloader mappings" to enable hardlinking and rapid importing.

  If you do not have these mappings, $program can't rename and move the files on import.
  This will result in files being copied instead of moved, and it will cause other issues.

  The mappings are on the download client settings (advanced setting), at the bottom of the page.

  Visit https://github.com/Pandaura/PTS-Team/wiki/Remote-Path-Mappings for more information.

EOF
    fi
  tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠ Failure to perform manual configuration changes will cause problems!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🌍 Visit the wiki for instructions on how to configure $program.

 https://github.com/Pandaura/PTS-Team/wiki/$program

EOF
fi

####--------


if [[ "$program" == *"sabnzbd"* ]] || [[ "$program" == *"nzbget"* ]]  ; then
    cclean=$(cat /var/plexguide/cloneclean)
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💬 NOTE / INFO
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  for incomplete downloads $program used the folder $hdpath/incomplete/nzb
  for finished downloads $program used the folder $hdpath/downloads/nzb

  beware the cloneclean is set to $cclean min

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
fi

if [[ "$program" == *"sabnzbd"* ]] ; then
    
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💬 sabnzbd api_key = $sbakey
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
fi
if [[ "$program" == *"rutorrent"* ]] || [[ "$program" == *"qbittorrent"* ]] || [[ "$program" == *"deluge"* ]]; then
    cclean=$(cat /var/plexguide/cloneclean)
    tclean=$(($cclean*2))
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💬 NOTE / INFO
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  for incomplete downloads $program used the folder $hdpath/incomplete/torrent
  for finished downloads $program used the folder $hdpath/downloads/torrent

  beware the cloneclean is set to $tclean min

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
fi
if [ "$program" == "plex" ]; then
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💬 Manual Configuration Required
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

we prefer using plex_autoscan, unlike other alternatives,
that does not put a lot of pressure on the API of your Google Account.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
fi

if [ "$hdpath" != "/mnt" ]; then
    sbakey=$(cat /opt/appdata/sabnzbd/sabnzbd.ini | grep "api_key" | head -n 1 | awk '{print $3}')
  tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
You must add /mnt self to the docker container again
Your $hdpath is not /mnt
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
fi
}

badinput() {
  echo ""
  echo "⚠️ ERROR - Bad Input! $typed not exist"
  echo ""
  read -p 'PRESS [ENTER] ' typed </dev/tty
}

startup() {
  rm -rf /var/plexguide/pgupdater.output 1>/dev/null 2>&1
  rm -rf /var/plexguide/pgbox.buildup 1>/dev/null 2>&1
  rm -rf /var/plexguide/program.temp 1>/dev/null 2>&1
  rm -rf /var/plexguide/app.list 1>/dev/null 2>&1
  touch /var/plexguide/pgupdater.output
  touch /var/plexguide/program.temp
  touch /var/plexguide/app.list
  touch /var/plexguide/pgbox.buildup

  docker ps | awk '{print $NF}' | tail -n +2 >/var/plexguide/pgbox.running
  docker ps | awk '{print $NF}' | tail -n +2 >/var/plexguide/app.list
}

autoupdateall() {
  cp /var/plexguide/program.temp /var/plexguide/pgupdater.output
  appselect
}

appselect() {

#  docker ps | awk '{print $NF}' | tail -n +2 >/var/plexguide/pgbox.running
#  docker ps | awk '{print $NF}' | tail -n +2 >/var/plexguide/app.list

  ### Clear out temp list
  rm -rf /var/plexguide/program.temp && touch /var/plexguide/program.temp

  ### List out installed apps
  num=0
  tree -d -L 1 /opt/appdata | awk '{print $2}' | tail -n +2 | head -n -2 >/var/plexguide/app.list
  
  sed -i -e "/plexguide/d" /var/plexguide/app.list
  sed -i -e "/oauth/d" /var/plexguide/app.list
  sed -i -e "/traefik/d" /var/plexguide/app.list
  sed -i -e "/wp-*/d" /var/plexguide/app.list
  sed -i -e "/*-vpn/d" /var/plexguide/app.list

  p="/var/plexguide/pgbox.running"
  while read p; do
    echo -n $p >>/var/plexguide/program.temp
    echo -n " " >>/var/plexguide/program.temp
    num=$((num + 1))
    if [[ "$num" == "7" ]]; then
      num=0
      echo " " >>/var/plexguide/program.temp
    fi
  done </var/plexguide/app.list

  notrun=$(cat /var/plexguide/program.temp)
  buildup=$(cat /var/plexguide/pgupdater.output)

  if [ "$buildup" == "" ]; then buildup="NONE"; fi
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🛈 Multi-App Auto Updater
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📂 Potential Apps to Auto Update

$notrun

💾 Apps Queued for Auto Updating

$buildup

[A] Install

[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  read -p '↪️ Type App Name to Queue Auto Updating | Type ALL to select all | Press [ENTER]: ' typed </dev/tty

  if [[ "${typed}" == "deploy" || "${typed}" == "install" || "${typed}" == "a" ]]; then start; fi

  if [[ "${typed}" == "exit" || "${typed}" == "z" ]]; then exit; fi

  current=$(cat /var/plexguide/pgbox.buildup | grep "\<$typed\>")
  if [ "$current" != "" ]; then queued && appselect; fi

  if [[ "$typed" == "all" || "$typed" == "All" || "$typed" == "ALL" ]]; then :;
  else
    current=$(cat /var/plexguide/program.temp | grep "\<$typed\>")
    if [ "$current" == "" ]; then badinput && appselect; fi;
  fi

  queueapp
}

queueapp() {
  if [[ "$typed" == "all" || "$typed" == "All" || "$typed" == "ALL" ]]; then autoupdateall ; else echo "$typed" >>/var/plexguide/pgbox.buildup; fi

  num=0

  touch /var/plexguide/pgupdater.output && rm -rf /var/plexguide/pgupdater.output && touch /var/plexguide/pgupdater.output

  while read p; do
    echo -n $p >>/var/plexguide/pgupdater.output
    echo -n " " >>/var/plexguide/pgupdater.output
    num=$((num + 1))
    if [[ "$num" == 7 ]]; then
      num=0
      echo " " >>/var/plexguide/pgupdater.output
    fi
  done </var/plexguide/pgbox.buildup

  sed -i "/^$typed\b/Id" /var/plexguide/app.list

  appselect
}

complete() {
  read -p '✅ Process Complete! | PRESS [ENTER] ' typed </dev/tty
  echo
  exit
}

start() {
    startup
    appselect
}

# FUNCTIONS END ##############################################################
echo "" >/tmp/output.info
start
