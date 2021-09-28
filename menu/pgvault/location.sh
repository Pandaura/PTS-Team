#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
source /opt/plexguide/menu/functions/start.sh
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
↘️  SETTING: Backup Download Location
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Paying attention to your disk space is important! Type the name of your
location is very important! Keep in mind Pandaura does not format the
location for you!

Examples:
1. /opt/appdata/plexguide
2. /hd2/spongebob

NOTE: Start with a / and end with no trailing slash!
EOF
end_menu_back
# Standby
read -p 'TYPE the location | Press [ENTER]: ' typed </dev/tty
if [[ "${typed}" == "exit" || "${typed}" == "z" ]]; then exit; fi

tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️  NOTICE: Checking - $typed's existance. Please standby...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

if [ "$typed" == "" ]; then
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️ WARNING! - The ID cannot be blank!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    bash /opt/plexguide/menu/interface/serverid.sh
    exit
else
    
    ##################################################### TYPED CHECKERS - START
    typed2=$typed
    bonehead=no
    ##### If BONEHEAD forgot to add a / in the beginning, we fix for them
    initial="$(echo $typed | head -c 1)"
    if [ "$initial" != "/" ]; then
        typed="/$typed"
        bonehead=yes
    fi
    ##### If BONEHEAD added a / at the end, we fix for them
    initial="${typed: -1}"
    if [ "$initial" == "/" ]; then
        typed=${typed::-1}
        bonehead=yes
    fi
    
    ##### Notify User is a Bonehead
    if [ "$bonehead" == "yes" ]; then
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️ ALERT! We fixed the typos for you! Yes, you're welcome.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

You Typed : $typed2
Changed To: $typed

EOF
        read -n 1 -s -r -p "Press [ANY KEY] to continue "
        echo ""
    fi
    
    #################################################### TYPED CHECKERS - END
    
    mkdir "$typed/pgcheck" &>/dev/null
    # Recalls for to check existance
    rcheck=$(ls -la $typed | grep "\<pgcheck\>")
    if [ "$rcheck" == "" ]; then
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️ WARNING! - This location does not exist! Exiting... (Case senstive)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
        sleep 4
        exit
    fi
    
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️ PASS: Location! Storing the name of the location!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    # Prevents From Repeating
    rm -rf $typed/pgcheck
    sleep 3
    
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌇  PASS: Process complete!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    echo "$typed" >/var/plexguide/data.location
    read -n 1 -s -r -p "Press [ANY] Key to Continue "
    
fi
