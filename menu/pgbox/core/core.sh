#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

# FUNCTIONS START ##############################################################
source /opt/plexguide/menu/functions/functions.sh

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

badinputcore() {
  echo ""
  echo "⛔️ ERROR - Bad Input! $typed not exist"
  echo ""
  read -p 'PRESS [ENTER] ' typed </dev/tty
}

cronexe() {
  croncheck=$(cat /opt/coreapps/apps/_cron.list | grep -c "\<$p\>")
  if [ "$croncheck" == "0" ]; then bash /opt/plexguide/menu/cron/cron.sh; fi
}

cronmass() {
  croncheck=$(cat /opt/coreapps/apps/_cron.list | grep -c "\<$p\>")
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

  folder && ansible-playbook /opt/plexguide/menu/pgbox/core/core.yml >/dev/null 2>&1

  file="/opt/coreapps/place.holder"
  waitvar=0
  while [ "$waitvar" == "0" ]; do
    sleep .5
    if [ -e "$file" ]; then waitvar=1; fi
  done
  apt-get install dos2unix -yqq
  dos2unix /opt/coreapps/apps/image/_image.sh >/dev/null 2>&1
  dos2unix /opt/coreapps/apps/_appsgen.sh >/dev/null 2>&1
}

question1() {

  ### Remove Running Apps
  while read p; do
    sed -i "/^$p\b/Id" /var/plexguide/app.list
  done </var/plexguide/pgbox.running

  cp /var/plexguide/app.list /var/plexguide/app.list2

  file="/var/plexguide/core.app"
  #if [ ! -e "$file" ]; then
  ls -la /opt/coreapps/apps | sed -e 's/.yml//g' |
    awk '{print $9}' | tail -n +4 >/var/plexguide/app.list
  while read p; do
    echo "" >>/opt/coreapps/apps/$p.yml
    echo "##PG-Core" >>/opt/coreapps/apps/$p.yml

    mkdir -p /opt/mycontainers
    touch /opt/appdata/plexguide/rclone.conf
  done </var/plexguide/app.list
  touch /var/plexguide/core.app
  #fi

  #bash /opt/coreapps/apps/_appsgen.sh
  docker ps | awk '{print $NF}' | tail -n +2 >/var/plexguide/pgbox.running

  ### Remove Official Apps
  while read p; do
    # reminder, need one for custom apps
    baseline=$(cat /opt/coreapps/apps/$p.yml | grep "##PG-Core")
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
🚀 Multi-App Installer | Core Edition
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
  if [ "$current" == "" ]; then badinputcore && question1; fi

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

    bash /opt/coreapps/apps/image/_image.sh

    # CName & Port Execution
    bash /opt/plexguide/menu/pgbox/cname.sh
  done </var/plexguide/pgbox.buildup

  # Cron Execution
  edition=$(cat /var/plexguide/pg.edition)
  if [[ "$edition" == "PG Edition - HD Solo" ]]; then
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
	value
    # Store Used Program
    echo "$p" >/tmp/program_var
    # Execute Main Program
    ansible-playbook /opt/coreapps/apps/$p.yml

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


start() {
    boxversion="official"
    initial
    question1
}

folder() {
mkdir -p /opt/coreapps
}


# FUNCTIONS END ##############################################################
echo "" >/tmp/output.info
start
