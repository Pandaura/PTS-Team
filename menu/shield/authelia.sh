#!/bin/bash
#
# Title:      Traefikv2 with Authelia over Cloudflare
# OS Branch:  ubuntu,debian,rasbian
# Author(s):  mrdoob
# Editor:     Hawks
# GNU:        General Public License v3.0
################################################################################
# shellcheck disable=SC2003
# shellcheck disable=SC2006
# shellcheck disable=SC2207
# shellcheck disable=SC2012
# shellcheck disable=SC2086
# shellcheck disable=SC2196
# shellcheck disable=SC2046
#FUNCTIONS

########## FUNCTIONS START

displayname() {
basefolder="/opt/appdata"
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Authelia Username
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
   read -erp "Enter your username for Authelia (eg. John Doe): " DISPLAYNAME

if [[ $DISPLAYNAME != "" ]];then
   if [[ $(uname) == "Darwin" ]];then
      sed -i '' "s/<DISPLAYNAME>/$DISPLAYNAME/g" $basefolder/authelia/users_database.yml
      sed -i '' "s/<USERNAME>/$DISPLAYNAME/g" $basefolder/authelia/users_database.yml
   else
      sed -i "s/<DISPLAYNAME>/$DISPLAYNAME/g" $basefolder/authelia/users_database.yml
      sed -i "s/<USERNAME>/$DISPLAYNAME/g" $basefolder/authelia/users_database.yml
   fi
else
  echo "Display name cannot be empty"
  displayname
fi
interface
}

password() {
basefolder="/opt/appdata"
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Authelia Password
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
   read -erp "Enter a password for $USERNAME: " PASSWORD

if [[ $PASSWORD != "" ]];then
   $(command -v docker) pull authelia/authelia -q > /dev/null
   PASSWORD=$($(command -v docker) run authelia/authelia authelia hash-password $PASSWORD -i 2 -k 32 -m 128 -p 8 -l 32 | sed 's/Password hash: //g')
   JWTTOKEN=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
   SECTOKEN=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
   if [[ $(uname) == "Darwin" ]];then
      sed -i '' "s/<PASSWORD>/$(echo $PASSWORD | sed -e 's/[\/&]/\\&/g')/g" $basefolder/authelia/users_database.yml
      sed -i '' "s/JWTTOKENID/$(echo $JWTTOKEN | sed -e 's/[\/&]/\\&/g')/g" $basefolder/authelia/configuration.yml
      sed -i '' "s/unsecure_session_secret/$(echo $SECTOKEN | sed -e 's/[\/&]/\\&/g')/g" $basefolder/authelia/configuration.yml
   else
      sed -i "s/<PASSWORD>/$(echo $PASSWORD | sed -e 's/[\/&]/\\&/g')/g" $basefolder/authelia/users_database.yml
      sed -i "s/JWTTOKENID/$(echo $JWTTOKEN | sed -e 's/[\/&]/\\&/g')/g" $basefolder/authelia/configuration.yml
      sed -i "s/unsecure_session_secret/$(echo $SECTOKEN | sed -e 's/[\/&]/\\&/g')/g" $basefolder/authelia/configuration.yml
   fi
else
   echo "Password cannot be empty"
   password
fi
interface
}

deploynow() {
basefolder="/opt/appdata"
compose="compose/docker-compose.yml"
envcreate

#cd $basefolder/compose && $(command -v docker-compose) up -d --force-recreate 1>/dev/null 2>&1 && sleep 5
$(command -v cd) $basefolder/compose/
if [[ -f $basefolder/$compose ]];then
   $(command -v docker-compose) config 1>/dev/null 2>&1
   code=$?
   if [[ $code -ne 0 ]];then
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    ❌ ERROR
    compose check has failed || Return code is ${code}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
   read -erp "Confirm Info | PRESS [ENTER]" typed </dev/tty
   clear && interface
   fi
fi
if [[ -f $basefolder/$compose ]];then
   $(command -v docker-compose) pull 1>/dev/null 2>&1
   code=$?
   if [[ $code -ne 0 ]];then
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    ❌ ERROR
    compose pull has failed || Return code is ${code}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
   read -erp "Confirm Info | PRESS [ENTER]" typed </dev/tty
   clear && interface
   fi
fi
if [[ -f $basefolder/$compose ]];then
   $(command -v docker-compose) up -d --force-recreate 1>/dev/null 2>&1
   source $basefolder/compose/.env
   tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   🚀 Authelia
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	    Authelia is deployed
        Please wait for Authelia to start-up 
	    it needs some time to start all the services

        Authelia:   https://authelia.${DOMAIN}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
clear && interface
fi
}
######################################################
interface() {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Shield - Protect your domain
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Shield Status                   [ $SHIELDSTATUS ]
[2] Admin Username                  [ $DISPLAYNAME ]
[3] Admin Password                  [ $PASSWORD ]

[4] Add user
[5] Remove user

[L] List users

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[E] Enable Shield
[D] Disable Shield

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[Z] - Exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  read -erp '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in

     1) domain && clear && interface ;;
     2) displayname && clear && interface ;;
     3) password && clear && interface ;;
     4) cfemail && clear && interface ;;
     5) cfkey && clear && interface ;;
     6) cfzoneid && clear && interface ;;
     d) deploynow && clear && interface ;;
     D) deploynow && clear && interface ;;
     z) exit 0 ;;
     Z) exit 0 ;;
     *) clear && interface ;;

  esac
}
# FUNCTIONS END ##############################################################
updatesystem
