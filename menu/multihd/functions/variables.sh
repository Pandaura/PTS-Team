#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
rolevars() {
  mkdir -p /var/plexguide/

  variable() {
    file="$1"
    if [ ! -e "$file" ]; then echo "$2" >$1; fi
  }

  variablet() {
    file="$1"
    if [ ! -e "$file" ]; then touch "$1"; fi
  }

  # set variables if they do not exist
  variable /var/plexguide/vfs_rcsl "2048M"
  vfs_rcsl=$(cat /var/plexguide/vfs_rcsl)
  variable /var/plexguide/multihd.paths ""

}
