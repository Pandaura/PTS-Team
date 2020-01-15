#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
source /opt/plexguide/menu/functions/functions.sh
source /opt/plexguide/menu/functions/serverid.sh
source /opt/plexguide/menu/functions/emergency.sh
source /opt/plexguide/menu/functions/serverid.sh
source /opt/plexguide/menu/functions/update.sh
#######################################################

pginstall() {
  versionubucheck
  updateprime
  gcecheck
  core pythonstart
  core aptupdate
  core alias
  core folders
  core dependency
  core mergerfsinstall
  core dockerinstall
  core docstart
  rollingpart
  portainer
  oruborus
  core motd
  core gcloud
  core cleaner
  core serverid
  core prune
  pgedition
  core mountcheck
  emergency
  pgdeploy
  # oruborus
}

############################################################ INSTALLER FUNCTIONS
versionubucheck() {
versioncheck=$(cat /etc/*-release | grep "Ubuntu" | grep -E '19')
  if [[ "$versioncheck" == "19" ]]; then
printf '
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔ WOAH! ......  System OS Warning!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Supported: UBUNTU 16.xx - 18.10 ~ LTS/SERVER and Debian 9.* / 10

This server may not be supported due to having the incorrect OS detected!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
'
  exit 1
  else echo "18" >${abc}/os.version.check; fi
}

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
  variable ${abc}/data.location "/mnt/backup"
  pgnumber=$(cat /var/plexguide/pg.number)
  variable /var/plexguide/server.hd.path "/mnt"

  hostname -I | awk '{print $1}' >${abc}/server.ip
  file="${abc}/server.hd.path"
  if [[ ! -e "$file" ]]; then echo "/mnt" >${abc}/server.hd.path; fi

  file="${abc}/new.install"
  if [[ -f "$file" ]]; then newinstall; fi

  ospgversion=$(lsb_release -si)
  if [[ "$ospgversion" == "Ubuntu" ]]; then
    echo "ubuntu" >${abc}/os.version
  else 
    echo "debian" >${abc}/os.version; 
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
  echo "1" >${abc}/pg.amazonaws
  echo "8.4" >${abc}/pg.verionid
  echo "1" >${abc}/pg.installer
  echo "7" >${abc}/pg.prune
  echo "21" >${abc}/pg.mountcheck
  echo "11" >${abc}/pg.watchtower
}
oruborus() {
wstatus=$(docker ps --format '{{.Names}}' | grep "watchtower")
if [[ "$wstatus" == "watchtower" ]]; then 
    docker stop watchtower >/dev/null 2>&1
	docker rm watchtower >/dev/null 2>&1
	ansible-playbook /opt/plexguide/menu/functions/ouroboros.yml
fi
ostatus=$(docker ps --format '{{.Names}}' | grep "ouroboros")
if [[ "$ostatus" != "ouroboros" ]]; then ansible-playbook /opt/plexguide/menu/functions/ouroboros.yml; fi
}
gcecheck() {
gcheck=$(dnsdomainname | tail -c 10)
if [[ "$gcheck" == ".internal" ]]; then
        if [[ "$(tail -n 1 /var/plexguide/gce.done)" == "1" ]]; then
		tee <<-EOF
        ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        📂  Google Cloud Feeder Edition SET!
        ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
         NVME already mounted on /mnt with size $(df -h /mnt/ --total --local -x tmpfs | grep 'total' | awk '{print $2}')
        ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
		EOF
		echo "YES" >/var/plexguide/pg.gce
        else bash /opt/plexguide/menu/pggce/gcechecker.sh; fi
else echo "NO" >/var/plexguide/pg.gce; fi
}

rollingpart() {
  touch ${abc}/install.roles
  rolenumber=3
  # Roles Ensure that PG Replicates and has once if missing; important for startup, cron and etc
  if [[ $(cat /var/plexguide/install.roles) != "$rolenumber" ]]; then
    rm -rf /opt/{coreapps,communityapps,pgshield} 
    ansible-playbook /opt/plexguide/menu/pgbox/community/community.yml
    ansible-playbook /opt/plexguide/menu/pgbox/core/core.yml
	clone
    echo "$rolenumber" >${abc}/install.roles
  fi
 }

core() {
  touch ${abc}/pg."${1}".stored
  start=$(cat /var/plexguide/pg."${1}")
  stored=$(cat /var/plexguide/pg."${1}".stored)
  if [[ "$start" != "$stored" ]]; then
    $1
    cat ${abc}/pg."${1}" >${abc}/pg."${1}".stored
  fi
}

alias() { 
ansible-playbook /opt/plexguide/menu/alias/alias.yml
}
aptupdate() { 
ansible-playbook /opt/plexguide/menu/pg.yml --tags update
}
cleaner() { 
ansible-playbook /opt/plexguide/menu/pg.yml --tags autodelete,clean,journal
}
dependency() {
  ospgversion=$(cat /var/plexguide/os.version)
  if [[ "$ospgversion" == "debian" ]]; then
    ansible-playbook /opt/plexguide/menu/dependency/dependencydeb.yml
  else
    ansible-playbook /opt/plexguide/menu/dependency/dependency.yml
  fi
}
docstart() { 
ansible-playbook /opt/plexguide/menu/pg.yml --tags docstart
}
folders() { 
ansible-playbook /opt/plexguide/menu/installer/folders.yml
}
prune() { 
ansible-playbook /opt/plexguide/menu/prune/main.yml
}
gcloud() { 
ansible-playbook /opt/plexguide/menu/pg.yml --tags gcloud_sdk
}
mergerfsinstall() { 
ansible-playbook /opt/plexguide/menu/pg.yml --tags mergerfsinstall
}
motd() { 
ansible-playbook /opt/plexguide/menu/motd/motd.yml
}
mountcheck() { 
ansible-playbook /opt/plexguide/menu/installer/mcdeploy.yml
}
newinstall() {
  rm -rf ${abc}/pg.exit 1>/dev/null 2>&1
  file="${abc}/new.install"
  if [[ -f "$file" ]]; then
    touch ${abc}/pg.number && echo "off" >/tmp/program_source
    file="${abc}/new.install"
    if [[ ! -f "$file" ]]; then exit; fi
  fi
}
pgdeploy() { 
touch ${abc}/pg.edition && bash /opt/plexguide/menu/start/start.sh 
}
pgedition() {
  file="${abc}/project.deployed"
  if [[ ! -e "$file" ]]; then echo "no" >${abc}/project.deployed; fi
  file="${abc}/project.keycount"
  if [[ ! -e "$file" ]]; then echo "0" >${abc}/project.keycount; fi
  file="${abc}/server.id"
  if [[ ! -e "$file" ]]; then echo "[NOT-SET]" -rf >${abc}/rm; fi
}
portainer() {
  dstatus=$(docker ps --format '{{.Names}}' | grep "portainer")
  if [[ "$dstatus" != "portainer" ]]; then ansible-playbook /opt/plexguide/menu/functions/portainer.yml; fi
}
# Roles Ensure that PG Replicates and has once if missing; important for startup, cron and etc
pgcore() { 
file="${abc}/new.install"
if [[ -f "$file" ]]; then ansible-playbook /opt/plexguide/menu/pgbox/core/core.yml; fi
if [[ -f "$file" ]]; then ansible-playbook /opt/plexguide/menu/pgbox/community/community.yml; fi
}
clone() {
file="${abc}/new.install"
if [[ -f "$file" ]]; then
	 echo 'pgclone' >${abc}/pgcloner.rolename
	 echo 'PTS-Clone' >${abc}/pgcloner.roleproper
	 echo 'PTS-Clone' >${abc}/pgcloner.projectname
	 echo 'final' >${abc}/pgcloner.projectversion
	 echo 'pgclone.sh' >${abc}/pgcloner.startlink
     ansible-playbook "/opt/plexguide/menu/pgcloner/clone/primary.yml"
	 sleep 0.1
	 echo 'traefik' >${abc}/pgcloner.rolename
     echo 'Traefik' >${abc}/pgcloner.roleproper
     echo 'Traefik' >${abc}/pgcloner.projectname
     echo 'master' >${abc}/pgcloner.projectversion
     echo 'traefik.sh' >${abc}/pgcloner.startlink
     ansible-playbook "/opt/plexguide/menu/pgcloner/clone/primary.yml"	 
fi
}
pythonstart() {
file="${abc}/new.install"
if [[ -f "$file" ]]; then bash /opt/plexguide/menu/roles/pythonstart/pyansible.sh; fi
}
dockerinstall() {
file="${abc}/new.install"
if [[ -f "$file" ]]; then ansible-playbook /opt/plexguide/menu/pg.yml --tags docker; fi
}
####EOF###