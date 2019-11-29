#!/bin/bash
#
# Title:      pts (Reference Title File)
# Author(s):  Admin9705 - FlickerRate
# URL:        https://pts.com - http://github.pts.com
# GNU:        General Public License v3.0
################################################################################
source /opt/plexguide/menu/functions/install.sh
emergency

ending(){
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
│                                     │
└─────────────────────────────────────┘

EOF
####################
file="/bin/pts"
if [[ -f $file ]]; then
  alias 1>/dev/null 2>&1
  owned 1>/dev/null 2>&1
fi
}
