#!/bin/bash
#
# Title:      pts (Reference Title File)
# Author(s):  Admin9705 - FlickerRate
# URL:        https://pts.com - http://github.pts.com
# GNU:        General Public License v3.0
################################################################################
source /opt/plexguide/menu/functions/install.sh
emergency
file="/bin/pandaura"
if [[ ! -f "/bin/pandaura" ]]; then
  cp /opt/plexguide/menu/alias/templates/pts /bin && chown 1000:1000 /bin/pandaura && chmod 0755 /bin/pandaura; fi
#
clear 
 printf '
┌─────────────────────────────────────┐
│        -==   Pandaura  ==-          │
│ ————————————————————————————————————│
│ Restart PTS:              pts       │
│ Update  PTS:              ptsupdate │
│ View the PTS Logs:        blitz     │
│ Download Your PTS Fork:   pgfork    │
│                                     │
│ ————————————————————————————————————│
│ Thanks For being a part of the team │
│                                     │
│ Thanks to:                          │
│                                     │
│ Hawkinzzz, Syndrogo, Anap_          │
│ Xaritomi, Demon, Man1234,           │
│ Pianomanx, xr3negadex, salty,       │       |
│                                     │
└─────────────────────────────────────┘
'
