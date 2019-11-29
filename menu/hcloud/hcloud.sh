#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
source /opt/plexguide/menu/functions/install.sh

installtest(){
file="/bin/hcloud"
  if [[ -f $file ]]; then
  tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 Hetzner's Cloud install check
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
 else   
  version="$(curl -s https://api.github.com/repos/hetznercloud/cli/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')"
  wget -P /tmp "https://github.com/hetznercloud/cli/releases/download/$version/hcloud-linux-amd64-$version.tar.gz"
  tar -xvf "/tmp/hcloud-linux-amd64-$version.tar.gz" -C /tmp
  mv "/tmp/hcloud-linux-amd64-$version/bin/hcloud" /bin/
  rm -rf /tmp/hcloud-linux-amd64-$version.tar.gz
  rm -rf /tmp/hcloud-linux-amd64-$version; fi
}

testhcloud(){
test=$(hcloud server list)
if [ "$test" == "" ]; then

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! - You Must Input an API Token from Hetzner First!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[ 1 } Activate a Hetzner Cloud Account 
[ 2 ] Create a Project
[ 3 ] Click Access (left hand side)
[ 4 ] click API Tokens
[ 5 ] Create a Token and Save It (and paste below here)

* Not Ready? Just type something & Press [ENTER]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  hcloud context create plexguide

  test=$(hcloud server list)
  if [ "$test" == "" ]; then
    hcloud context delete plexguide
    exit
  fi

fi
}
#--------------------------------------------------------------------
main(){
# Start Process
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 Hetzner's Cloud Generator
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[ 1 ] Deploy a New Server
[ 2 ] Destory a Server

[ A ] List Server Info
[ B ] Display Inital Server Passwords

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[Z] Exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1) 
  create && clear && main ;;
  2) 
  destroy && clear && main ;;
  A) 
  list && clear && main ;;
  a) 
  list && clear && main ;;
  B) 
  display && clear && main ;;
  b) 
  display && clear && main ;;
  Z) 
  exit ;;
  z) 
  exit ;;
  *) 
  main ;;
  esac
}
#-----------------------------------------------------------------
create(){
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
↘️  Create a Server Name
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  read -p 'Type a Server Name | Press [ENTER]: ' name </dev/tty
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
↘️  Hetzner's Cloud OS Selector
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Ubuntu 18.04              [ PTS works ]
[2] Ubuntu 16.04              [ PTS works ]

[3] Debian 9                  [ only for testing | PTS dont works ]
[4] Debian 10                 [ only for testing | PTS dont works ]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[Z] Exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

  # Standby
  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1) os="ubuntu-18.04" ;; 
  2) os="ubuntu-16.04" ;;
  3) os="debian-9" ;; 
  4) os="debian-10" ;;
  z) exit ;;
  Z) exit ;;
  *) main ;;
  esac


  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Deploying Your Server!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  hcloud server create --name $name --type cx11 --image $os >/opt/appdata/plexguide/server.info

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
↘️  New Server Information - [$name]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  cat /opt/appdata/plexguide/server.info

  # Creates Log
  touch /opt/appdata/plexguide/server.store
  cat /opt/appdata/plexguide/server.info >>/opt/appdata/plexguide/server.store
  echo "Server Name: $name" >>/opt/appdata/plexguide/server.store
  echo "" >>/opt/appdata/plexguide/server.store

  # Variable Info
  serverip=$(cat /opt/appdata/plexguide/server.info | tail -n +3 | head -n 1 | cut -d " " -f2-)
  initialpw=$(cat /opt/appdata/plexguide/server.info | tail -n +4 | cut -d " " -f3-)

  tee <<-EOF

⚠️  To Reach Your Server >>> Exit PTS >>> TYPE: pg-$name ⚠️

✅️ [IMPORTANT NOTE]

Wait for one minute for the server to boot! Typing pg-$name will
display your initial password! Also can manually by typing:

Command: ssh root@$serverip
FIRST TIME LOGIN - Initial Password: $initialpw

EOF
  read -p 'Press [ENTER] to Exit ' fill </dev/tty

  # Creates Command pg-whatevername 2
  echo "" >>/bin/pg-$name
  echo "echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >/bin/pg-$name
  echo "echo '↘️  Server - $name | Initial Password $initialpw'" >>/bin/pg-$name
  echo "echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >>/bin/pg-$name
  echo "echo ''" >>/bin/pg-$name
  echo "ssh root@$serverip" >>/bin/pg-$name
  chmod -R 777 /bin/pg-$name
  chown -R 1000:1000 /bin/pg-$name
}

#------------------------------------

list(){
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
↘️  Hetzner Server Cloud List
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Server Name
━━━━━━━━━━━

EOF
  hcloud server list | tail -n +2 | cut -d " " -f2- | cut -d " " -f2- | cut -d " " -f2-
  echo
  read -p 'Press [ENTER] to Continue! ' typed </dev/tty
}

#------------------------------------

destroy(){
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
↘️  Destory a Hetzner Cloud Server!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Server Name
━━━━━━━━━━━

EOF
  hcloud server list | tail -n +2 | cut -d " " -f2- | cut -d " " -f2- | cut -d " " -f2-
  echo
  echo "[Z] Exit"
  read -p 'Type a Server to Destroy | Press [ENTER]: ' destroy </dev/tty
  if [[ "$destroy" == "exit" || "$destroy" == "Exit" || "$destroy" == "EXIT" || "$destroy" == "z" || "$destroy" == "Z" ]]; then
    main
    exit
  else
    check=$(hcloud server list | tail -n +2 | cut -d " " -f2- | cut -d " " -f2- | cut -d " " -f2-)
    next=$(echo $check | grep -c "\<$destroy\>")
    if [ "$next" == "0" ]; then
      tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  Server: $destroy - Does Not Exist!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
      read -p 'Press [ENTER] to Continue! ' typed </dev/tty
		main
    fi
    echo
    hcloud server delete $destroy
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
↘️  Server: $destroy - Destroyed!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    read -p 'Press [ENTER] to Continue! ' typed </dev/tty
    rm -rf /bin/pg-$destroy
  fi
}
#------------------------------------
display(){
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
↘️  Inital Server Passwords
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

 [ $initialpw ]

⚠️  Useful if NEVER logged in! List created by this Server (new > old)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

  touch /opt/appdata/plexguide/server.store
  tac -r /opt/appdata/plexguide/server.store
  echo "" &
  echo ""
  read -p 'Press [ENTER] to Continue! ' corn </dev/tty
}
##############################################################
installtest
testhcloud
main