#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

### FILL OUT THIS AREA ###
echo 'rclone' >/var/plexguide/pgcloner.rolename
echo 'rClone' >/var/plexguide/pgcloner.roleproper
echo 'rClone' >/var/plexguide/pgcloner.projectname
echo 'master' >/var/plexguide/pgcloner.projectversion
echo 'pgclone.sh' >/var/plexguide/pgcloner.startlink

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo "💬 rClone utilizes RClone's Mounts + MergerFS's Union" >/var/plexguide/pgcloner.info
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

### START PROCESS
bash /opt/plexguide/menu/pgcloner/corev2/main.sh
