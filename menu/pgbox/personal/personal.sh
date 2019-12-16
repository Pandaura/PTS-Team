#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

# FUNCTIONS START ##############################################################
source /opt/plexguide/menu/functions/functions.sh
variable /var/plexguide/boxpersonal.user NON-SET
variable /var/plexguide/boxpersonal.repo NON-SET
variable /var/plexguide/boxpersonal.branch NON-SET


queued() {
  echo
  read -p "⛔️ ERROR - $typed Already Queued! | Press [ENTER] " typed </dev/tty
  question1
}

value() {
bash /opt/plexguide/menu/pgbox/value.sh
}

exists() {
  echo ""
  echo "⛔️ ERROR - $typed Already Installed!"
  read -p '⚠️  Reinstall? [Y/N] | Press [ENTER] ' foo </dev/tty

  if [[ "$foo" == "y" || "$foo" == "Y" ]]; then
    part1
  elif [[ "$foo" == "n" || "$foo" == "N" ]]; then
    question1
  else exists; fi
}

cronexe() {
  croncheck=$(cat /opt/mycontainers/apps/_cron.list | grep -c "\<$p\>")
  if [ "$croncheck" == "0" ]; then bash /opt/plexguide/menu/cron/cron.sh; fi
}

cronmass() {
  croncheck=$(cat /opt/mycontainers/apps/_cron.list | grep -c "\<$p\>")
  if [ "$croncheck" == "0" ]; then bash /opt/plexguide/menu/cron/cron.sh; fi
}

initial() {
  rm -rf /var/plexguide/pgbox.output 1>/dev/null 2>&1
  rm -rf /var/plexguide/pgbox.buildup 1>/dev/null 2>&1
  rm -rf /var/plexguide/program.temp 1>/dev/null 2>&1
  rm -rf /var/plexguide/app.list 1>/dev/null 2>&1
  touch /var/plexguide/pgbox.output
  touch /var/plexguide/program.temp
  touch /var/plexguide/app.list
  touch /var/plexguide/pgbox.buildup

  mkdir -p /opt/mycontainers

  ansible-playbook /opt/plexguide/menu/pgbox/personal/personal.yml
  file="/opt/mycontainers/place.holder"
  waitvar=0
  while [ "$waitvar" == "0" ]; do
    sleep .5
    if [ -e "$file" ]; then waitvar=1; fi
  done

}

question1() {

  ### Remove Running Apps
  while read p; do
    sed -i "/^$p\b/Id" /var/plexguide/app.list
  done </var/plexguide/pgbox.running

  cp /var/plexguide/app.list /var/plexguide/app.list2

  file="/var/plexguide/personal.app"
  #if [ ! -e "$file" ]; then
  ls -la /opt/mycontainers/apps | sed -e 's/.yml//g' |
    awk '{print $9}' | tail -n +4 >/var/plexguide/app.list
  while read p; do
    echo "" >>/opt/mycontainers/apps/$p.yml
    echo "##PG-personal" >>/opt/mycontainers/apps/$p.yml

    mkdir -p /opt/mycontainers
    touch /opt/appdata/plexguide/rclone.conf
  done </var/plexguide/app.list
  touch /var/plexguide/personal.app
  #fi

  #bash /opt/mycontainers/apps/_appsgen.sh
  docker ps | awk '{print $NF}' | tail -n +2 >/var/plexguide/pgbox.running

  ### Remove Official Apps
  while read p; do
    # reminder, need one for custom apps
    baseline=$(cat /opt/mycontainers/apps/$p.yml | grep "##PG-personal")
    if [ "$baseline" == "" ]; then sed -i -e "/$p/d" /var/plexguide/app.list; fi
  done </var/plexguide/app.list

  ### Blank Out Temp List
  rm -rf /var/plexguide/program.temp && touch /var/plexguide/program.temp

  ### List Out Apps In Readable Order (One's Not Installed)
  num=0
  sed -i -e "/templates/d" /var/plexguide/app.list
  sed -i -e "/image/d" /var/plexguide/app.list
  sed -i -e "/watchtower/d" /var/plexguide/app.list
  sed -i -e "/_/d" /var/plexguide/app.list
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
  buildup=$(cat /var/plexguide/pgbox.output)

  if [ "$buildup" == "" ]; then buildup="NONE"; fi
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 PTS ~ Multi-App Installer  || Personal Versions
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📂 Potential Apps to Install

$notrun

💾 Apps Queued for Installation

$buildup

[A] Install

[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  read -p '↪️ Type app to queue install | Press [ENTER]: ' typed </dev/tty

  if [[ "$typed" == "deploy" || "$typed" == "Deploy" || "$typed" == "DEPLOY" || "$typed" == "install" || "$typed" == "Install" || "$typed" == "INSTALL" || "$typed" == "a" || "$typed" == "A" ]]; then question2; fi

  if [[ "$typed" == "exit" || "$typed" == "Exit" || "$typed" == "EXIT" || "$typed" == "z" || "$typed" == "Z" ]]; then exit; fi

  current=$(cat /var/plexguide/pgbox.buildup | grep "\<$typed\>")
  if [ "$current" != "" ]; then queued && question1; fi

  current=$(cat /var/plexguide/pgbox.running | grep "\<$typed\>")
  if [ "$current" != "" ]; then exists && question1; fi

  current=$(cat /var/plexguide/program.temp | grep "\<$typed\>")
  if [ "$current" == "" ]; then badinput1 && question1; fi

  part1
}

part1() {
  echo "$typed" >>/var/plexguide/pgbox.buildup
  num=0

  touch /var/plexguide/pgbox.output && rm -rf /var/plexguide/pgbox.output

  while read p; do
    echo -n $p >>/var/plexguide/pgbox.output
    echo -n " " >>/var/plexguide/pgbox.output
    if [[ "$num" == 7 ]]; then
      num=0
      echo " " >>/var/plexguide/pgbox.output
    fi
  done </var/plexguide/pgbox.buildup

  sed -i "/^$typed\b/Id" /var/plexguide/app.list

  question1
}

final() {
  read -p '✅ Process Complete! | PRESS [ENTER] ' typed </dev/tty
  echo
  exit
}

question2() {

  # Image Selector
  image=off
  while read p; do

    echo "$p" >/tmp/program_var
	if [[ -d "/opt/mycontainers/apps/image/" ]]; then
    bash /opt/mycontainers/apps/image/_image.sh ; fi

    # CName & Port Execution
    bash /opt/plexguide/menu/pgbox/cname.sh
  done </var/plexguide/pgbox.buildup

  # Cron Execution
  edition=$(cat /var/plexguide/pg.edition)
  if [[ "$edition" == "Edition - HD Solo" ]]; then
    a=b
  else
    croncount=$(sed -n '$=' /var/plexguide/pgbox.buildup)
    echo "false" >/var/plexguide/cron.count
    if [ "$croncount" -ge 2 ]; then bash /opt/plexguide/menu/cron/mass.sh; fi
  fi

  while read p; do
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
$p - Now Installing!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

    sleep 1
    ##### CHECK START #####
    value
    ##### CHECK EXIT #####

    # Store Used Program
    echo "$p" >/tmp/program_var
    # Execute Main Program
    ansible-playbook /opt/mycontainers/apps/$p.yml

    if [[ "$edition" == "PG Edition - HD Solo" ]]; then
      a=b
    elif [ "$croncount" -eq "1" ]; then cronexe; fi

    # End Banner
    bash /opt/plexguide/menu/pgbox/endbanner.sh >>/tmp/output.info

    sleep 2
  done </var/plexguide/pgbox.buildup
  echo "" >>/tmp/output.info
  cat /tmp/output.info
  final
}

mainbanner() {

  boxuser=$(cat /var/plexguide/boxpersonal.user)
  boxrepo=$(cat /var/plexguide/boxpersonal.repo)
  boxbranch=$(cat /var/plexguide/boxpersonal.branch)
 

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 PTS personal Box Edition!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬	
User:	$boxuser 
Repo:	$boxrepo
Branch: $boxbranch

[1] Change User Name & Branch
[2] Deploy personal Box - Personal (Forked)

[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

  read -p 'Type a Selection | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1)
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💬 IMPORTANT MESSAGE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Username / Branch & Repo are both case sensitive!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    read -p 'Username | Press [ENTER]: ' boxuser </dev/tty
    read -p 'REPO     | Press [ENTER]: ' boxrepo </dev/tty
    read -p 'Branch   | Press [ENTER]: ' boxbranch </dev/tty
    echo "$boxuser" >/var/plexguide/boxpersonal.user
    echo "$boxrepo" >/var/plexguide/boxpersonal.repo
    echo "$boxbranch" >/var/plexguide/boxpersonal.branch
    mainbanner
    ;;
  2)
    existcheck=$(git ls-remote --exit-code -h "https://github.com/$(cat /var/plexguide/boxpersonal.user)/$(cat /var/plexguide/boxpersonal.repo)" | grep "$(cat /var/plexguide/boxpersonal.branch)")
    if [ "$existcheck" == "" ]; then
      echo
      read -p '💬 Exiting! Forked Version Does Not Exist! | Press [ENTER]: ' typed </dev/tty
      mainbanner
    fi

    initial && question1 ;;
  z) exit ;;
  Z) exit ;;
  *) mainbanner ;;
  esac
}

# FUNCTIONS END ##############################################################
 
echo "" >/tmp/output.info
mainbanner
