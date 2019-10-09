#!/bin/bash
#
# Title:      PTS Community 
# Author:     MrDoob
# URL:        WTFH >-!-< why you need this ^^ 
# GNU:        General Public License v3.0
#
################################################################################
mkdir -p /var/plexguide/checkers
rm -rf /var/plexguide/checkers/*.log
#mkdir -p /var/plexguide/checkers

###mergerfs part
mgversion="$(curl -s https://api.github.com/repos/trapexit/mergerfs/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')"
touch /var/plexguide/checkers/mgfs.log
touch /var/plexguide/checkers/mergerfs.log

mergfs="$(mergerfs -v | grep 'mergerfs version:' | awk '{print $3}')"
echo "$mergfs" >> /var/plexguide/checkers/mgfs.log

mgstored="$(tail -n 1 /var/plexguide/checkers/mgfs.log)"

if [[ "$mgversion" == "$mgstored" ]];then
        echo " ✅  No update needed !" >/var/plexguide/checkers/mergerfs.log
elif [[ "$mgversion" != "$mgstored" ]]; then
        echo " ⛔ Update possible !" >/var/plexguide/checkers/mergerfs.log
else echo "stupid line"

fi
##### rclpone part
rcversion="$(curl -s https://api.github.com/repos/rclone/rclone/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')"
touch /var/plexguide/checkers/rclonestored.log
touch /var/plexguide/checkers/rclone.log
rcstored="$(rclone --version | awk '{print $2}' | tail -n 3 | head -n 1 )"
echo "$rcstored" >> /var/plexguide/checkers/rclonestored.log

rcstored="$(tail -n 1 /var/plexguide/checkers/rclonestored.log)"

if [[ "$rcversion" == "$rcstored" ]]; then
        echo " ✅  No update needed !" >/var/plexguide/checkers/rclone.log
elif [[ "rcversion" != "rcstored" ]]; then
        echo " ⛔  Update possible !" >/var/plexguide/checkers/rclone.log
else echo "stupid line"

fi
