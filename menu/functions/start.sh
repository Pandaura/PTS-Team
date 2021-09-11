#!/bin/bash
#
# Title:      PTS major file
# org.Author(s):  Admin9705 - Deiteq
# Mod from MrDoob for PTS
# GNU:        General Public License v3.0
################################################################################
source /opt/plexguide/menu/functions/functions.sh
source /opt/plexguide/menu/functions/install.sh
declare YELLOW='\033[0;33m'
declare NC='\033[0m'

sudocheck() {
    if [[ $EUID -ne 0 ]]; then
    tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️  You Must Execute as a SUDO USER (with sudo) or as ROOT!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
        exit 0
    fi
}

downloadpg() {
    rm -rf /opt/plexguide
    git clone --single-branch https://github.com/Pandaura/PTS-Team.git /opt/plexguide  1>/dev/null 2>&1
    ansible-playbook /opt/plexguide/menu/version/missing_pull.yml
    ansible-playbook /opt/plexguide/menu/alias/alias.yml  1>/dev/null 2>&1
    rm -rf /opt/plexguide/place.holder >/dev/null 2>&1
    rm -rf /opt/plexguide/.git* >/dev/null 2>&1
}

missingpull() {
    file="/opt/plexguide/menu/functions/install.sh"
    if [ ! -e "$file" ]; then
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️  Base folder is missing!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
        sleep 2
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🍖  NOM NOM - Re-Downloading Pandaura
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
        sleep 2
        downloadpg
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️  Repair Complete! Standby!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
        sleep 2
    fi
}

exitcheck() {
    bash /opt/plexguide/menu/version/file.sh
    file="/var/plexguide/exited.upgrade"
    if [ ! -e "$file" ]; then
        bash /opt/plexguide/menu/interface/ending.sh
    else
        rm -rf /var/plexguide/exited.upgrade 1>/dev/null 2>&1
        echo ""
        bash /opt/plexguide/menu/interface/ending.sh
    fi
}
top_menu() {

    # Menu Interface
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🛈 $transport               Version: $pgnumber               ID: $serverid
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
- SB-API Access: 🟢   - Internal API Access: 🟢   - HERE?         🔴
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                                                 | $Update Available: 🟢| # This will show when an update is available
Disk Used Space: $used of $capacity | $percentage Used Capacity
EOF
}

disk_space_used_space() {
      # Displays Second Drive of GCE
  edition=$(cat /var/plexguide/pg.server.deploy)
  if [ "$edition" == "feeder" ]; then
    used_gce=$(df -h /mnt --local | tail -n +2 | awk '{print $3}')
    capacity_gce=$(df -h /mnt --local | tail -n +2 | awk '{print $2}')
    percentage_gce=$(df -h /mnt --local | tail -n +2 | awk '{print $5}')
    echo " GCE disk used space: $used_gce of $capacity_gce | $percentage_gce Used Capacity"
  fi

  disktwo=$(cat "/var/plexguide/server.hd.path")
  if [ "$edition" != "feeder" ]; then
    used_gce2=$(df -h "$disktwo" --local | tail -n +2 | awk '{print $3}')
    capacity_gce2=$(df -h "$disktwo" --local | tail -n +2 | awk '{print $2}')
    percentage_gce2=$(df -h "$disktwo" --local | tail -n +2 | awk '{print $5}')

    if [[ "$disktwo" != "/mnt" ]]; then
      echo " 2nd disk used space: $used_gce2 of $capacity_gce2 | $percentage_gce2 Used Capacity"
    fi
  fi
}

end_menu() {
    tee <<-EOF
_________________________________________________________________________
                                                                [Z]  Exit
https://discord.gg/KhyKMzXgax                         https://sudobox.io/
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
}

sub_menu_networking() { # first sub menu
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🛈 $transport               Version: $pgnumber               ID: $serverid
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1]${YELLOW}\"Networking"${NC}     : Reverse Proxy | Domain Setup                   
    [A] Reverse Proxy    - Setup a domain using Traefik              [🟢 ]
    [B] Port Security    - Close vulnerable container ports          [🟢 ]
[2]  Security       : Secure your server                             
[3]  Mount          : Mount Cloud Based Storage                      
[4]  Apps           : Apps ~ Core, Community & Removal                
[5]  Vault          : Backup & Restore                               
-------------------------------------------------------------------------
[9] Tools           : Tools 
[0] Settings        : Settings

EOF
  }

  sub_menu_security() { # Menu Interface
  tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🛈 $transport               Version: $pgnumber               ID: $serverid
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1]  Networking     : Reverse Proxy | Domain Setup                   
[2]  Security       : Secure your server                             
    [A] Authelia    - Single Sign-On MFA Portal                      [🟢 ]
    [B] PortGuard   - guard innit                                    [🟢 ]
    [B] VPN         - guard innit                                    [🟢 ]
[3]  Mount          : Mount Cloud Based Storage                      
[4]  Apps           : Apps ~ Core, Community & Removal               
[5]  Vault          : Backup & Restore                               
-------------------------------------------------------------------------
[9] Tools           : Tools 
[0] Settings        : Settings
_________________________________________________________________________
                                                                [Z]  Exit
https://discord.gg/KhyKMzXgax                         https://sudobox.io/
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  }