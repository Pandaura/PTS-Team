#!/bin/bash
###############################################################################
# Title: PlexGuide | PTS ( base installer )
#
# Author(s): 	Admin9705 
# Coder : 	MrDoob - freelance Coder | ammj93 | prodengineer pr00f
# URL: 		https://PTS.com
# Base :	http://github.PTS.com
# GNU: General Public License v3.0E
#
################################################################################
#function
logfile=/var/log/log.info
package_list="curl wget software-properties-common git zip unzip dialog sudo nano htop mc lshw"

##fast change the editions
edition=master
##fast change the editions

tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  INSTALLING: PTS Notice
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
By Installing PTS, you are agreeing to the terms and conditions
of the GNUv3 Project License! Please Standby...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 3
#check it is being run as root
if [ "$(id -u)" != "0" ]; then
  	echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	echo ""
	echo " ⛔ Warning! "
	echo " ⛔ Warning! insufficient permission "
	echo " ⛔ Warning! "
	echo ""
	echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" && exit 1
fi
##check for open port ( apache and Nginx test )
apt-get install lsof -yqq 2>&1 >> /dev/null
	export DEBIAN_FRONTEND=noninteractive
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⌛  Check for existing Webserver is running - Standby
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
if lsof -Pi :80 -sTCP:LISTEN -t >/dev/null ; then
        service apache2 stop 2>&1 >> /dev/null
        service nginx stop 2>&1 >> /dev/null
        apt-get purge apache nginx -yqq 2>&1 >> /dev/null
        apt-get autoremove -yqq 2>&1 >> /dev/null
        apt-get autoclean -yqq 2>&1 >> /dev/null
	
elif lsof -Pi :443 -sTCP:LISTEN -t >/dev/null ; then
        service apache2 stop 2>&1 >> /dev/null
        service nginx stop 2>&1 >> /dev/null
        apt-get purge apache nginx -yqq 2>&1 >> /dev/null
        apt-get autoremove -yqq 2>&1 >> /dev/null
        apt-get autoclean -yqq 2>&1 >> /dev/null

else
    echo "Good no service runs on port 80 & 443"
fi
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ PASSED ! Check for existing Webserver is done !
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 5
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⌛  Base install - Standby
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
apt-get install lsb-release -yqq 2>&1 >> /dev/null
	export DEBIAN_FRONTEND=noninteractive
apt-get install software-properties-common -yqq 2>&1 >> /dev/null
	export DEBIAN_FRONTEND=noninteractive
#repo-check
fullrel=$(lsb_release -sd)
osname=$(lsb_release -si)
## original code relno=$(lsb_release -sr | cut -d. -f1)
relno=$(lsb_release -sr)
hostname=$(hostname -I | awk '{print $1}')
# add repo
osname=$([ "$osname" = "Ubuntu" ] && [ $relno -ge 15 ] && [ $relno -le 18.09 ) || ([ "$osname" = "Debian" ] && [ $relno -ge 8 ])
if echo $osname "Debian" ; then
	add-apt-repository main 2>&1 >> /dev/null
	add-apt-repository non-free 2>&1 >> /dev/null
	add-apt-repository contrib 2>&1 >> /dev/null
elif echo $osname "Ubuntu" ; then
	add-apt-repository main 2>&1 >> /dev/null
	add-apt-repository universe 2>&1 >> /dev/null
	add-apt-repository restricted 2>&1 >> /dev/null
	add-apt-repository multiverse 2>&1 >> /dev/null
elif echo $osname "Rasbian" "Fedora" "CentOS"; then
	echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	echo " ⛔ Warning!"
	echo " ⛔ Warning Only Ubuntu release 16/18.04 LTS/SERVER and Debian 9 above are supported"
	echo " ⛔ Warning Your system does not appear to be supported"
	echo " ⛔ Warning!"
	echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
       	exit 1
fi
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ PASSED Base Install - finish
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⌛  Update the System - Standby
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
apt-get update -yqq 2>&1 >> /dev/null
	export DEBIAN_FRONTEND=noninteractive
apt-get upgrade -yqq 2>&1 >> /dev/null
	export DEBIAN_FRONTEND=noninteractive
apt-get dist-upgrade -yqq 2>&1 >> /dev/null
	export DEBIAN_FRONTEND=noninteractive
apt-get autoremove -yqq 2>&1 >> /dev/null
	export DEBIAN_FRONTEND=noninteractive
apt-get install $package_list -yqq 2>&1 >> /dev/null
	export DEBIAN_FRONTEND=noninteractive
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ PASSED Update the System - finish
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 5
##usercheck
if [ $(grep "1000" /etc/passwd | cut -d: -f1 | awk '{print $1}') ]; then
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        echo " ✅ PASSED ! We found the user UID " $(grep "1000" /etc/passwd | cut -d: -f1 | awk '{print $1}')
        echo ""
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
else
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo " ⌛ INFO ! "
        echo " ⌛ INFO ! Only lowercase and dont empty parts"
        echo " ⌛ INFO ! Enter a password (8+ chars)"
        echo " ⌛ INFO ! "
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        read -p "Enter username : " username
        read -s -p "Enter password : " password
        echo ""
        egrep "^$username" /etc/passwd >/dev/null
                pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
                useradd -m -p $pass $username
                usermod -aG sudo $username
                sudo usermod -s /bin/bash $username
        echo ""
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo " ✅ PASSED ! User has been added to system!"
        echo " ✅ PASSED ! Your Username : " $username
        echo " ✅ PASSED ! Your Password : " $password
        echo " ✅ PASSED ! "
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
fi
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
😂 What a Lame name: $(grep "1000" /etc/passwd | cut -d: -f1 | awk '{print $1}')
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
😂 What a Lame name: $(grep "1000" /etc/passwd | cut -d: -f1 | awk '{print $1}')
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 10
#ram test
if [ "$(free -m | grep Mem | awk 'NR=1 {print $2}')" -ge "8190" ]; then
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	echo ""
	echo " ✅️  PASSED ! PTS RAM test okay"
	echo " ✅️  PASSED ! RAM Space meets recommended requirements"
	echo ""
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" && sleep 2
fi
if [ "$(free -m | grep Mem | awk 'NR=1 {print $2}')" -le "4095" ]; then
	echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	echo ""
	echo " ⛔ Warning !"
	echo " ⛔ Warning ! Your RAM space is too low , you can run into issues"
	echo " ⛔ Warning ! PG will run fine, but do not run too many Apps"
	echo " ⛔ Warning !"
	echo ""
	echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" && sleep 2
fi
space="$(df -m / --total --local -x tmpfs | grep 'total' | awk '{print $2}')"
if [ $space -gt "511900" ] ; then
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        echo " ✅  PASSED! HDD Space test okay"
        echo " ✅  PASSED! HDD Sapce meets Recommended requirement"
        echo ""
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"  && sleep 2
fi
if [ "$space" -ge "81920" -a "$space" -le "511899" ] ; then 
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        echo " ⌛  INFO ! HDD Space test okay"
        echo " ⌛  INFO ! over Minimum requirement and under Recommend"
        echo ""
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"  && sleep 2
fi
if [ $space -le "81920" ] ; then
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        echo " ⛔ Warning !"
        echo " ⛔ Warning ! Your HDD space is too low , you can run into issues"
        echo " ⛔ Warning ! PG will run fine, but do not run too many Apps"
        echo " ⛔ Warning !"
        echo ""
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" && sleep 2
fi
sleep 2
# Delete If it Exist for Cloning
file="/opt/plexguide"
if [ -e "$file" ]; then rm -rf /opt/plexguide; fi

file="/opt/pgstage"
if [ -e "$file" ]; then rm -rf /opt/pgstage; fi

rm -rf /opt/pgstage/place.holder 2>&1 >> /dev/null

git clone -b $edition --single-branch https://github.com/MrDoobPG/Install.git /opt/pgstage 1>/dev/null 2>&1

mkdir -p /var/plexguide/logs
echo "" > /var/plexguide/server.ports
echo "51" > /var/plexguide/pg.pythonstart
touch /var/plexguide/pg.pythonstart.stored
start=$(cat /var/plexguide/pg.pythonstart)
stored=$(cat /var/plexguide/pg.pythonstart.stored)

if [ "$start" != "$stored" ]; then
bash /opt/pgstage/pyansible.sh 2>&1 >> /dev/null
fi
echo "51" > /var/plexguide/pg.pythonstart.stored

#pip upgrade
pip install --upgrade pip 2>&1 >> /dev/null
echo "PIP updated"

ansible-playbook /opt/pgstage/clone.yml 2>&1 >> /dev/null
cp /opt/plexguide/menu/alias/templates/plexguide /bin/plexguide 2>&1 >> /dev/null
cp /opt/plexguide/menu/alias/templates/pgblitz /bin/pgblitz 2>&1 >> /dev/null
cp /opt/plexguide/menu/alias/templates/pg /bin/pg 2>&1 >> /dev/null
cp /opt/plexguide/menu/alias/templates/pts /bin/pts 2>&1 >> /dev/null

tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⌛  Verifiying PTS / PTS Installed @ /bin/plexguide - Standby!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 2

file="/bin/plexguide"
if [ ! -e "$file" ]; then

tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! Installed Failed! PTS / PTS Command Missing!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Please Reinstall PTS by running the Command Again! We are doing
this to ensure that your installation continues to work!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
exit
fi
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️ PASSED! The PTS / PTS Command Installed!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ PASSED ! Your Username        : $(grep "1000" /etc/passwd | cut -d: -f1 | awk '{print $1}')
✅ PASSED ! Operations System    : $(lsb_release -sd)
✅ PASSED ! Processor            : $(lshw -class processor | grep "product" | awk '{print $2,$3,$4,$5,$6,$7,$8,$9}')
✅ PASSED ! CPUs                 : $(lscpu | grep "CPU(s):" | tail +1 | head -1 | awk  '{print $2}')
✅ PASSED ! IP from Server       : $hostname
✅ PASSED ! HDD Space            : $(df -h / --total --local -x tmpfs | grep 'total' | awk '{print $2}')
✅ PASSED ! RAM Space            : $(free -m | grep Mem | awk 'NR=1 {print $2}') MB
✅ PASSED ! Logfile              : $logfile
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
rm -rf /var/plexguide/new.install 1>/dev/null 2>&1
sleep 2
chmod 775 /bin/plexguide
chown 1000:1000 /bin/plexguide
chmod 775 /bin/pgblitz
chown 1000:1000 /bin/pgblitz
chmod 775 /bin/pts
chown 1000:1000 /bin/pts

## Other Folders
mkdir -p /opt/appdata/plexguide
mkdir -p /var/plexguide

tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
↘️  Start AnyTime By Typing >>> pts [or] plexguide [or] pgblitz
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF