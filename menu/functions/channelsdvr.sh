#!/bin/bash
channelsdvr() {
hdpath=$(cat /var/plexguide/server.hd.path)

  tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📁 Channels-DVR local Path
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: In order for this to work, you must set the PATH 
      to where Channels-DVR can save the local files.

Possible folder

$hdpath/channeldvr
$hdpath/mydvr
$hdpath/dvrfolder

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Go Back? Type > exit

EOF
  read -p '↘️ Type channelsdvr local Location | Press [ENTER]: ' typed </dev/tty

  if [[ "$typed" == "exit" || "$typed" == "Exit" || "$typed" == "EXIT" || "$typed" == "z" || "$typed" == "Z" ]]; then
    exit 0
  else
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 SYSTEM MESSAGE: Checking Path $typed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    sleep 1.5

    ##################################################### TYPED CHECKERS - START
    typed2=$typed
    bonehead=no
    ##### If user forgot to add a / in the beginning, we fix for them
    initial="$(echo $typed | head -c 1)"
    if [ "$initial" != "/" ]; then
      typed="/$typed"
    fi
    ##### If user added a / at the end, we fix for them
    initial="${typed: -1}"
    if [ "$initial" == "/" ]; then
      typed=${typed::-1}
    fi

    ##################################################### TYPED CHECKERS - START
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 SYSTEM MESSAGE: Checking if Location is Valid
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    sleep 1.5

    mkdir $typed/test 1>/dev/null 2>&1

    file="$typed/test"
    if [ -e "$file" ]; then

      tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ SYSTEM MESSAGE: Channels-DVR Path Completed!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

      ### Removes /mnt if /mnt/unionfs exists
      #check=$(echo $typed | head -c 12)
      #if [ "$check" == "/mnt/unionfs" ]; then
      #typed=${typed:4}
      #fi

      echo "$typed" >/var/plexguide/channelsdvr.folder
      read -p '🌎 Acknowledge Info | Press [ENTER] ' typed </dev/tty
    else
      tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔ ALERT: Path $typed DOES NOT Exist! 
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Note: You must ensure that linux is able to READ your location.
      It's start again for you
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
      read -p '🌎 Acknowledge Info | Press [ENTER] ' typed </dev/tty
      channelsdvr
    fi
  fi

}

channelsdvr
