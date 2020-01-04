 #/bin/bash 
###VRKN_GLOBAL_MAXMIND_LICENSE_KEY
api() {
fid="/var/plexguide/varken/"
if [[ ! -d "$fid" ]]; then mkdir -p "$fid";fi

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📁 VRKN_GLOBAL_MAXMIND_LICENSE_KEY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: In order for this to work, you must retrieve your API Key! Prior to
continuing, please follow the current steps.

MaxMind:

1. Sign up for a MaxMind account. Make sure to verify the account.

2. Go to your Account, then Services > 
   My License Key in the side menu, then click "Generate New License Key".

3. Enter a License key description, 
   and select "No" for "Will this key be used for GeoIP Update?", then click "Confirm".

4. Enter your License Key of MaxMind

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '↘️ Type License Key of MaxMind | Press [ENTER]: ' typed </dev/tty
  echo $typed >/var/plexguide/varken/geoip.key
}
api
