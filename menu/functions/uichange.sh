#!/bin/bash
#
# Title:      PTS Settings Layout
# Mode from MrDoob for PTS
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
### executed parts 
uichange() {
switchcheck=$(cat /var/plexguide/pgui.switch)
    if [[ "$switchcheck" == "On" ]]; then
      echo "Off" >/var/plexguide/pgui.switch
      docker stop pgui &>/dev/null &
      docker rm pgui &>/dev/null &
      service localspace stop
	  systemctl daemon-reload
      rm -f /etc/systemd/system/localspace.servive
      rm -f /etc/systemd/system/mountcheck.service
	  clear
    tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️   WOOT WOOT: Process Complete!
✅️   WOOT WOOT: UI Removed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

    else
      echo "On" >/var/plexguide/pgui.switch
      ansible-playbook /opt/plexguide/menu/pgui/pgui.yml
      systemctl daemon-reload
      service localspace start
	  clear
    tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️   WOOT WOOT: Process Complete!
✅️   WOOT WOOT: UI installed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    fi
}