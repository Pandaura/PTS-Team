#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
addpoint() {
  rolevars
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Add HD or MountPoint
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE1: This point must EXIST! PTS does not format drives, nor mount
the secondary HDs for the user. Visit the URL to learn about the basics!
Feel free to add/change the wiki in ordeer to help us all!

NOTE2: Formatting Examples

/hd2/mystuff
/mystash/media
/nas/XXYZY/hiddenvideos
/media-NAS/storage/media
/secondhd/user/

Quitting? Type >>> q or exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  read -rp '↘️  Input Selection | Press [ENTER]: ' addpath </dev/tty

  if [[ "$addpath" == "exit" || "$addpath" == "Exit" || "$addpath" == "EXIT" || "$addpath" == "z" || "$addpath" == "Z" ]]; then multihdstart; fi
  if [[ "$addpath" == "" ]]; then addpoint; fi

  addpointcheck
}

addpointcheck() {

  # adds slashes if missing
  if [[ $(echo $addpath | cut -c1) != "/" ]]; then addpath="/$addpath"; fi
  if [[ $(echo $addpath | tail -c 2) == "/" ]]; then addpath="${addpath::-1}"; fi

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Processing Path: $addpath
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

  checkcheck1=$(ls -la "$addpath" 2>&1)
  checkcheck2=$(echo $checkcheck1 | grep "cannot access")

  # Checks to Make Sure the Path Is Valid
  if [[ "$checkcheck2" != "" ]]; then
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 ERROR NOTICE 
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

PATH: $addpath

NOTE: We are unable to verify that the following path above exists!
Type "ls -la $addpath"

Utilizing the above command may help determine what the problem is!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    read -rp '↘️  Acknowledge Info | Press [ENTER] ' typed </dev/tty
    addpoint
  fi

  checkcheck3=$(cat /var/plexguide/multihd.paths | grep "$addpath")
  if [[ "$checkcheck3" != "" ]]; then
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 ERROR NOTICE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

PATH: $addpath

NOTE: This path ALREADY EXISTS in the MultiHD Setup! There is nothing else
to do! EXITING!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    read -rp '↘️  Acknowledge Info | Press [ENTER] ' typed </dev/tty
    multihdstart
  fi

  # Congrats! The Path Exists and is now stored!
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 SUCCESS NOTICE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

PATH: $addpath

NOTE1: The path exists! The path has now been saved to our MultiHD list!

NOTE2: To take full affect Move/Blitz must be deployed/redeployed
through rClone!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

  echo $addpath >>/var/plexguide/multihd.paths
  read -rp '↘️  Acknowledge Info | Press [ENTER] ' typed </dev/tty

  multihdstart
}
