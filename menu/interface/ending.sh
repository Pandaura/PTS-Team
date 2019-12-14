#!/bin/bash
#
# Title:      pts (Reference Title File)
# Author(s):  Admin9705 - FlickerRate
# URL:        https://pts.com - http://github.pts.com
# GNU:        General Public License v3.0
################################################################################
source /opt/plexguide/menu/functions/install.sh
emergency
file="/bin/pts"
if [[ ! -f "/bin/pts" ]]; then
  cp /opt/plexguide/menu/alias/templates/pts /bin && chown 1000:1000 /bin/pts && chmod 0755 /bin/pts; fi
#
clear 
 printf '
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
│ l3uddz, RXWatcher, Calmcacil,       │
│ ΔLPHΔ , Maikash , Porkie            │
│ CDN_RAGE , hawkinzzz , The_DeadPool │
│ BugHunter : Krallenkiller           │
│                                     │
└─────────────────────────────────────┘
'



