#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
source /opt/plexguide/menu/functions/functions.sh

updateprime() {
  abc="/var/plexguide"
  mkdir -p ${abc}
  chmod 0775 ${abc}
  chown 1000:1000 ${abc}

  variable ${abc}/pgfork.project "UPDATE ME"
  variable ${abc}/pgfork.version "changeme"
  variable ${abc}/tld.program "portainer"
  variable /opt/appdata/plexguide/plextoken ""
  variable ${abc}/server.ht ""
  variable ${abc}/server.email "NOT-SET"
  variable ${abc}/server.domain "NOT-SET"
  variable ${abc}/pg.number "New-Install"
  variable ${abc}/emergency.log ""
  variable ${abc}/pgbox.running ""
  pgnumber=$(cat /var/plexguide/pg.number)

  hostname -I | awk '{print $1}' >${abc}/server.ip
  file="${abc}/server.hd.path"
  if [ ! -e "$file" ]; then echo "/mnt" >${abc}/server.hd.path; fi

  file="${abc}/new.install"
  if [ ! -e "$file" ]; then newinstall; fi

  ospgversion=$(cat /etc/*-release | grep Debian | grep 9)
  if [ "$ospgversion" != "" ]; then
    echo "debian" >${abc}/os.version
  else 
    echo "ubuntu" >${abc}/os.version; 
  fi

  echo "3" >${abc}/pg.mergerfsinstall
  echo "52" >${abc}/pg.pythonstart
  echo "12" >${abc}/pg.aptupdate
  echo "150" >${abc}/pg.preinstall
  echo "24" >${abc}/pg.folders
  echo "16" >${abc}/pg.dockerinstall
  echo "15" >${abc}/pg.server
  echo "1" >${abc}/pg.serverid
  echo "33" >${abc}/pg.dependency
  echo "11" >${abc}/pg.docstart
  echo "2" >${abc}/pg.motd
  echo "115" >${abc}/pg.alias
  echo "3" >${abc}/pg.dep
  echo "3" >${abc}/pg.cleaner
  echo "3" >${abc}/pg.gcloud
  echo "12" >${abc}/pg.hetzner
  echo "1" >${abc}/pg.amazonaws
  echo "8.4" >${abc}/pg.verionid
  echo "11" >${abc}/pg.watchtower
  echo "1" >${abc}/pg.installer
  echo "7" >${abc}/pg.prune
  echo "21" >${abc}/pg.mountcheck
}

pginstall() {
  updateprime
  bash /opt/plexguide/menu/pggce/gcechecker.sh
  core pythonstart
  core aptupdate
  core alias
  core folders
  core dependency
  core mergerfsinstall
  core dockerinstall
  core docstart

  touch ${abc}/install.roles
  rolenumber=3
  # Roles Ensure that PG Replicates and has once if missing; important for startup, cron and etc
  if [[ $(cat /var/plexguide/install.roles) != "$rolenumber" ]]; then
    rm -rf /opt/{coreapps,communityapps,pgshield} 

    pgcore
    pgcommunity
    pgshield
    echo "$rolenumber" >${abc}/install.roles
  fi
  rcloneinstall
  portainer
  core motd &>/dev/null &
  core hetzner &>/dev/null &
  core gcloud
  core cleaner &>/dev/null &
  core serverid
  core watchtower
  core prune
  customcontainers &>/dev/null &
  pgedition
  core mountcheck
  emergency
  pgdeploy
}

core() {
  touch ${abc}/pg."${1}".stored
  start=$(cat /var/plexguide/pg."${1}")
  stored=$(cat /var/plexguide/pg."${1}".stored)
  if [ "$start" != "$stored" ]; then
    $1
    cat ${abc}/pg."${1}" >${abc}/pg."${1}".stored
  fi
}

############################################################ INSTALLER FUNCTIONS
alias() {
  ansible-playbook /opt/plexguide/menu/alias/alias.yml
}

templatespart2() {
  ansible-playbook /opt/plexguide/menu/alias/alias.yml >/dev/null 2>&1
  ansible-playbook /opt/plexguide/menu/prune/main.yml >/dev/null 2>&1
  ansible-playbook /opt/plexguide/menu/pg.yml --tags journal >/dev/null 2>&1
  ansible-playbook /opt/plexguide/menu/motd/motd.yml >/dev/null 2>&1
}

aptupdate() {
  ansible-playbook /opt/plexguide/menu/pg.yml --tags update
}

customcontainers() {
  mkdir -p /opt/{coreapps,communityapps/apps,pgshield}
  touch /opt/appdata/plexguide/rclone.conf
  rclone --config /opt/appdata/plexguide/rclone.conf copy /opt/mycontainers/ /opt/communityapps/apps
}

cleaner() {
  ansible-playbook /opt/plexguide/menu/pg.yml --tags autodelete &>/dev/null &
  ansible-playbook /opt/plexguide/menu/pg.yml --tags clean &>/dev/null &
  ansible-playbook /opt/plexguide/menu/pg.yml --tags clean-encrypt &>/dev/null &
  ansible-playbook /opt/plexguide/menu/pg.yml --tags journal >/dev/null 2>&1
}

dependency() {
  ospgversion=$(cat /var/plexguide/os.version)
  if [ "$ospgversion" == "debian" ]; then
    ansible-playbook /opt/plexguide/menu/dependency/dependencydeb.yml
  else
    ansible-playbook /opt/plexguide/menu/dependency/dependency.yml
  fi
}

docstart() {
  ansible-playbook /opt/plexguide/menu/pg.yml --tags docstart
}

emergency() {
  abc="/var/plexguide"
  mkdir -p /opt/appdata/plexguide/emergency
  variable ${abc}/emergency.display "On"
  if [[ $(ls /opt/appdata/plexguide/emergency) != "" ]]; then

    # If not on, do not display emergency logs
    if [[ $(cat /var/plexguide/emergency.display) == "On" ]]; then

      tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  Emergency & Warning Log Generator 
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NOTE: This can be turned [On] or Off in Settings!

EOF

      countmessage=0
      while read p; do
        let countmessage++
        echo -n "${countmessage}. " && cat /opt/appdata/plexguide/emergency/$p
      done <<<"$(ls /opt/appdata/plexguide/emergency)"

      echo
      read -n 1 -s -r -p "Acknowledge Info | Press [ENTER]"
      echo
    else
      touch ${abc}/emergency.log
    fi
  fi

}

folders() {
  ansible-playbook /opt/plexguide/menu/installer/folders.yml
}

prune() {
  ansible-playbook /opt/plexguide/menu/prune/main.yml
}

hetzner() {
  version="$(curl -s https://api.github.com/repos/hetznercloud/cli/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')"
  wget -P /tmp "https://github.com/hetznercloud/cli/releases/download/$version/hcloud-linux-amd64-$version.tar.gz"
  tar -xvf "/tmp/hcloud-linux-amd64-$version.tar.gz" -C /tmp
  mv "/tmp/hcloud-linux-amd64-$version/bin/hcloud" /bin/
  rm -rf /tmp/hcloud-linux-amd64-$version.tar.gz
  rm -rf /tmp/hcloud-linux-amd64-$version
}

gcloud() {
  ansible-playbook /opt/plexguide/menu/pg.yml --tags gcloud_sdk
}

mergerfsupdate() {
  ansible-playbook /opt/plexguide/menu/pg.yml --tags mergerfsupdate
}

mergerfsinstall() {
  ansible-playbook /opt/plexguide/menu/pg.yml --tags mergerfsinstall
}

rcloneinstall() {
# ansible-playbook /opt/plexguide/menu/pg.yml --tags rcloneinstall
rcversion="$(curl -s https://api.github.com/repos/rclone/rclone/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')"
rcstored="$(rclone --version | awk '{print $2}' | tail -n 3 | head -n 1 )"

if [[ "$rcversion" == "$rcstored" ]]; then
  echo "✅ rclone latest stable version check "
  clear
elif [[ "$rcversion" != "$rcstored" ]]; then
  ansible-playbook /opt/plexguide/menu/pg.yml --tags rcloneinstall
  clear
fi
}

motd() {
  ansible-playbook /opt/plexguide/menu/motd/motd.yml
}

mountcheck() {
  ansible-playbook /opt/plexguide/menu/pgui/mcdeploy.yml
}

#localspace() {
#  ansible-playbook /opt/plexguide/menu/pgui/localspace.yml
#  ansible-playbook /opt/plexguide/menu/pgui/pgui.yml 
#}

newinstall() {
  rm -rf ${abc}/pg.exit 1>/dev/null 2>&1
  file="${abc}/new.install"
  if [ ! -e "$file" ]; then
    touch ${abc}/pg.number && echo off >/tmp/program_source
    bash /opt/plexguide/menu/version/file.sh
    file="${abc}/new.install"
    if [ ! -e "$file" ]; then exit; fi
  fi
}

pgdeploy() {
  touch ${abc}/pg.edition
  bash /opt/plexguide/menu/start/start.sh
}

pgedition() {
  file="${abc}/path.check"
  if [ ! -e "$file" ]; then touch ${abc}/path.check && bash /opt/plexguide/menu/dlpath/dlpath.sh; fi
  # FOR PG-BLITZ
  file="${abc}/project.deployed"
  if [ ! -e "$file" ]; then echo "no" >${abc}/project.deployed; fi
  file="${abc}/project.keycount"
  if [ ! -e "$file" ]; then echo "0" >${abc}/project.keycount; fi
  file="${abc}/server.id"
  if [ ! -e "$file" ]; then echo "[NOT-SET]" -rf >${abc}/rm; fi
}

portainer() {
  dstatus=$(docker ps --format '{{.Names}}' | grep "portainer")
  if [ "$dstatus" != "portainer" ]; then
    ansible-playbook /opt/coreapps/apps/portainer.yml &>/dev/null &
  fi
}

# Roles Ensure that PG Replicates and has once if missing; important for startup, cron and etc
pgcore() { if [ ! -e "/opt/coreapps/place.holder" ]; then ansible-playbook /opt/plexguide/menu/pgbox/pgboxcore.yml; fi; }
pgcommunity() { if [ ! -e "/opt/communityapps/place.holder" ]; then ansible-playbook /opt/plexguide/menu/pgbox/pgboxcommunity.yml; fi; }
pgshield() { if [ ! -e "/opt/pgshield/place.holder" ]; then
  echo 'pgshield' >${abc}/pgcloner.rolename
  echo 'PGShield' >${abc}/pgcloner.roleproper
  echo 'PGShield' >${abc}/pgcloner.projectname
  echo 'v8.6' >${abc}/pgcloner.projectversion
  echo 'pgshield.sh' >${abc}/pgcloner.startlink
  ansible-playbook "/opt/plexguide/menu/pgcloner/corev2/primary.yml"
fi; }

pythonstart() {
    bash /opt/plexguide/menu/roles/pythonstart/pyansible.sh >/dev/null 2>&1
}

dockerinstall() {
    ansible-playbook /opt/plexguide/menu/pg.yml --tags docker
}

serverid() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
↘️   Establishing Server ID               💬  Use One Word & Keep it Simple
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '🌏  TYPE Server ID | Press [ENTER]: ' typed </dev/tty

  if [ "$typed" == "" ]; then
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! - The Server ID Cannot Be Blank!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    sleep 1
    serverid
  else
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️  PASS: Server ID $typed Established
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    echo "$typed" >${abc}/server.id
    sleep 1
  fi
}

watchtower() {

  file="/var/plexguide/watchtower.wcheck"
  if [ ! -e "$file" ]; then
    echo "4" >${abc}/watchtower.wcheck
  fi

  wcheck=$(cat "${abc}/watchtower.wcheck")
  if [[ "$wcheck" -ge "1" && "$wcheck" -le "3" ]]; then
    wexit="1"
  else wexit=0; fi
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📂  WatchTower Edition
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬  WatchTower updates your containers soon as possible!

[1] Containers: Auto-Update All
[2] Containers: Auto-Update All Except | Plex & Emby
[3] Containers: Never Update

[Z] - Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  # Standby
  read -p 'Type a Number | Press [ENTER]: ' typed </dev/tty
  if [ "$typed" == "1" ]; then
    watchtowergen
    ansible-playbook /opt/coreapps/apps/watchtower.yml
    echo "1" >${abc}/watchtower.wcheck
  elif [ "$typed" == "2" ]; then
    watchtowergen
    sed -i -e "/plex/d" /tmp/watchtower.set 1>/dev/null 2>&1
    sed -i -e "/emby/d" /tmp/watchtower.set 1>/dev/null 2>&1
    sed -i -e "/jellyfin/d" /tmp/watchtower.set 1>/dev/null 2>&1
    ansible-playbook /opt/coreapps/apps/watchtower.yml
    echo "2" >${abc}/watchtower.wcheck
  elif [ "$typed" == "3" ]; then
    echo null >/tmp/watchtower.set
    ansible-playbook /opt/coreapps/apps/watchtower.yml
    echo "3" >${abc}/watchtower.wcheck
  elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then
    if [ "$wexit" == "0" ]; then
      tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️   WatchTower Preference Must be Set Once!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
      sleep 3
      watchtower
    fi
    exit
  else
    badinput
    watchtower
  fi
}

watchtowergen() {
  bash /opt/coreapps/apps/_appsgen.sh
  bash /opt/communityapps/apps/_appsgen.sh
  while read p; do
    echo -n $p >>/tmp/watchtower.set
    echo -n " " >>/tmp/watchtower.set
  done <${abc}/app.list
}
