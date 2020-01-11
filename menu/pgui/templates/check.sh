#!/bin/bash
#
# Title:      PTS Community 
# Author:     MrDoob
# URL:        WTFH >-!-< why you need this ^^ 
# GNU:        General Public License v3.0
#
################################################################################
mkdir -p /var/plexguide/checkers
truncate -s 0 /var/plexguide/checkers/*.log
###mergerfs part
touch /var/plexguide/checkers/mgfs.log
touch /var/plexguide/checkers/mergerfs.log
mgversion="$(curl -s https://api.github.com/repos/trapexit/mergerfs/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')"
mergfs="$(mergerfs -v | grep 'mergerfs version:' | awk '{print $3}')"
echo "$mergfs" >>/var/plexguide/checkers/mgfs.log
mgstored="$(tail -n 1 /var/plexguide/checkers/mgfs.log)"
if [[ "$mgversion" == "$mgstored" ]];then
        echo " ✅ !" >/var/plexguide/checkers/mergerfs.log
else echo " ⛔ Update possible !" >/var/plexguide/checkers/mergerfs.log;
fi
####rclone part
touch /var/plexguide/checkers/rclonestored.log
touch /var/plexguide/checkers/rclone.log
rcversion="$(curl -s https://api.github.com/repos/rclone/rclone/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')"
rcstored="$(rclone --version | awk '{print $2}' | tail -n 3 | head -n 1)"
echo "$rcstored" >/var/plexguide/checkers/rclonestored.log
rcstored="$(tail -n 1 /var/plexguide/checkers/rclonestored.log)"
if [[ "$rcversion" == "$rcstored" ]]; then
        echo " ✅ !" >/var/plexguide/checkers/rclone.log
else echo " ⛔  Update possible !" >/var/plexguide/checkers/rclone.log;
fi
