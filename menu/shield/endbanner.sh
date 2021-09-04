#!/bin/bash
#
# Title:      Authlelia Endbanner
# Author(s):  Pandaura 
#
# GNU:        General Public License v3.0
################################################################################
base() {
rm -rf /var/plexguide/shield.ui.check
touch  /var/plexguide/shield.ui.check

oauth=$(docker ps --format '{{.Names}}' | grep "oauth")
domain=$(cat /var/plexguide/server.domain)
pgui=$(docker ps --format '{{.Names}}' | grep "pgui")
email=$(cat /var/plexguide/pgshield.emails | head -n 1)
portainer=$(docker ps --format '{{.Names}}' | grep "portainer")
#######################################################

if [[ $pgui == "pgui" ]]; then
    echo -e "pgui" >>/var/plexguide/shield.ui.check
else
    if [[ $portainer == "portainer" ]]; then
    echo -e "portainer" >>/var/plexguide/shield.ui.check ; fi
fi

part=$(cat /var/plexguide/shield.ui.check)
}
########################################################

question() {
if [[ $oauth == "oauth" ]]; then

tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🛈 Authelia deploy validator
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Follow these steps to check Authelia:
[ 1 ] Open a new incognito tab on your browser
[ 2 ] Open https://${pgui}.${domain}
[ 3 ] Log in via using your details
      Authelia Username     =     ${email}

[ 3 - ERROR ] you do not see any E-mail Address
              about this text
			  so go back and add a E-mail Address

[ 4 ] now refresh the page ( non-incognito tab )

[ 4 - ERROR ] if you get an error and can't log in
			  delete your browser cache.

[ 4 - WORKS ] If you can see the login window 
			  and are through to your app then
        Authelia has deployed correctly.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

fi

  read -p 'Confirm Info | PRESS [ENTER] ' typed </dev/tty
}

########################################################
# functions start 
########################################################
base
question
