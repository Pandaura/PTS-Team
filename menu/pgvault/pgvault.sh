#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
source /opt/pgvault/functions.sh
source /opt/pgvault/pgvault.func
file="/var/plexguide/restore.id"
if [ ! -e "$file" ]; then
  echo "[NOT-SET]" >/var/plexguide/restore.id
fi

initial
apprecall
primaryinterface
