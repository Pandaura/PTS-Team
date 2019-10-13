#!/bin/bash
#
# Title:      PTS Community 
# Author:     MrDoob
# URL:        WTFH >-!-< why you need this ^^ 
# GNU:        General Public License v3.0
#
################################################################################

# Starting Actions
#networktools | vnstat | vnstati install | please wait"
apt-get install ethtool vnstat vnstati -yqq 2>&1 >>/dev/null
network="$(ifconfig | grep -E 'eno1|enp|ens5' | awk '{print $1}' | sed -e 's/://g')"
sed -i 's/eth0/'$network'/g' /etc/vnstat.conf
sed -i 's/UnitMode 0/UnitMode 1/g' /etc/vnstat.conf
sed -i 's/RateUnit 1/RateUnit 0/g' /etc/vnstat.conf
sed -i 's/Locale "-"/Locale "LC_ALL=en_US.UTF-8"/g' /etc/vnstat.conf
/etc/init.d/vnstat restart 2>&1 >>/dev/null

startscript() {

        while [ 1 ]; do

                rm -rf /var/plexguide/spaceused.log

                # move and downloads for the UI

                du -sh /mnt/move | awk '{print $1}' >>/var/plexguide/spaceused.log
                du -sh /mnt/downloads | awk '{print $1}' >>/var/plexguide/spaceused.log

                sleep 60

        done

}

# keeps the function in a loop
cheeseballs=0
while [[ "$cheeseballs" == "0" ]]; do startscript; done
