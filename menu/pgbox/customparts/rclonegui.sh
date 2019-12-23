 #/bin/bash 
####rcwebui.sh
start0() {
folder && rcwebui
}

folder() {
if [[ ! -e "/var/plexguide/rcwebui" ]]; then 
	remove
else create; fi
}

remove() {
	rm -rf /var/plexguide/rcwebui
	mkdir -p /var/plexguide/rcwebui
	echo "NOT-SET" >/var/plexguide/rcwebui/rcuser.user
	echo "NOT-SET" >/var/plexguide/rcwebui/rcpass.pass
}
create() {
	mkdir -p /var/plexguide/rcwebui
	echo "NOT-SET" >/var/plexguide/rcwebui/rcuser.user
	echo "NOT-SET" >/var/plexguide/rcwebui/rcpass.pass
}

rcwebui() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📁 rclone Webui username and password
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

In order of work :
Usernanme : $(cat /var/plexguide/traktarr/pgtrak.client)
Password  : $(cat /var/plexguide/rcwebui/rcpass.pass)

Go Back? Type > exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '↘️ Type Username | Press [ENTER]: ' typed </dev/tty
  echo $typed >/var/plexguide/rcwebui/rcuser.user
  read -p '↘️ Type Password | Press [ENTER]: ' typed </dev/tty
  echo $typed >/var/plexguide/rcwebui/rcpass.pass
  if [[ "$typed" == "exit" || "$typed" == "Exit" || "$typed" == "EXIT" || "$typed" == "z" || "$typed" == "Z" ]]; then
    exit 0
  else
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ SYSTEM MESSAGE: rclone webui username and password is set
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Usernanme : $(cat /var/plexguide/rcwebui/rcuser.user)
Password  : $(cat /var/plexguide/rcwebui/rcpass.pass)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    read -p '🌎 Acknowledge Info | Press [ENTER] ' typed </dev/tty
  fi
}

start0