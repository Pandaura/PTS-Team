#!/bin/bash
#
# Title:      pts (Reference Title File)
# Author(s):  Admin9705 - FlickerRate
# URL:        https://pts.com - http://github.pts.com
# GNU:        General Public License v3.0
################################################################################
source /opt/plexguide/menu/functions/install.sh
emergency

#
clear 
echo ""

cat <<"EOF"
┌─────────────────────────────────────┐
│         -==   Team PTS  ==-         │
│ ————————————————————————————————————│
│ Restart PTS:              pts       │
│ Update  PTS:              ptsupdate │
│ View the PTS Logs:        blitz     │
│ Download Your PTS Fork:   pgfork    │
│                                     │
│ ————————————————————————————————————│
│ Thanks For Being Part of the Team   │
│                                     │
│ Thanks to:                          │
│                                     │
│ Davaz, Deiteq, FlickerRate,         │
│ ClownFused, MrDoob, Sub7Seven,      │
│ TimeKills, The_Creator, Desimaniac, │
│ l3uddz, RXWatcher,Calmcacil, Porkie │
└─────────────────────────────────────┘

EOF

if [[ ! -e "/bin/pts" ]]; then
  cp /opt/plexguide/menu/alias/templates/pts /bin
fi

chown 1000:1000 /bin/pts &>/dev/null &
chmod 0755 /bin/pts &>/dev/null &
