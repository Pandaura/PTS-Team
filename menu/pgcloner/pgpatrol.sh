#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

### FILL OUT THIS AREA ###
echo 'pgpatrol' >/var/plexguide/pgcloner.rolename
echo 'PTS-Patrol' >/var/plexguide/pgcloner.roleproper
echo 'PTS-Patrol' >/var/plexguide/pgcloner.projectname
echo 'master' >/var/plexguide/pgcloner.projectversion
echo 'pgpatrol.sh' >/var/plexguide/pgcloner.startlink

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo "💬 PTS-Patrol can boot idle plex users, users utilizing multiple
ips (sharing the server), and much more!" >/var/plexguide/pgcloner.info
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

### START PROCESS
bash /opt/plexguide/menu/pgcloner/corev2/main.sh