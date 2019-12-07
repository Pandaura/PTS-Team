#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
#remove old direction  if exist
old="/opt/blitzgce/blitzgce.sh"

if [[ -e $old ]]; then
 rm -rf /opt/blitzgce/ >/dev/null 2>&1
fi

source /opt/plexguide/menu/gce/functions/main.sh
source /opt/plexguide/menu/gce/functions/interface.sh
source /opt/plexguide/menu/gce/functions/ip.sh
source /opt/plexguide/menu/gce/functions/deploy.sh
source /opt/plexguide/menu/gce/functions/destroy.sh

# BAD INPUT
badinput() {
  echo
  read -p '⛔️ ERROR - BAD INPUT! | PRESS [ENTER] ' typed </dev/tty
  gcestart
}
sudocheck() {
  if [[ $EUID -ne 0 ]]; then
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  You Must Execute as a SUDO USER (with sudo) or as ROOT!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    exit 1
  fi
}

### the primary interface for GCE
gcestart() {

    ### call key variables ~ /functions/main.sh
    variablepull

    ### For New Installs; hangs because of no account logged in yet; this prevents
    othercheck=$(cat /var/plexguide/project.account)
    secondcheck=$(cat /var/plexguide/project.id)
    if [[ "$othercheck" != "NOT-SET" ]]; then

        if [[ "$secondcheck" != "NOT-SET" ]]; then
            servercheck
        else
            projectid=NOT-SET
            gcedeployedcheck=NOT-SET
        fi
    else
        account=NOT-SET
        projectid=NOT-SET
        gcedeployedcheck=NOT-SET
    fi

    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 GCE Deployment
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[ 1 ] Log Into the Account  : [ $account ]
[ 2 ] Project Interface     : [ $projectid ]
[ 3 } Processor Count       : [ $processor ]
[ 4 ] Ram Count             : [ $ramcount ]
[ 5 ] NVME Count            : [ $nvmecount ]
[ 6 ] OS Image              : [ $imagecount ] | [ $osdrive ]
[ 7 ] Set IP Region / Server: [ $ipaddress ]  | [ $ipregion ]
[ 8 ] Deploy GCE Server     : [ $gcedeployedcheck ]

[ 9 ] SSH into the GCE Box

[ C ] Calculator

[ A ] Destroy Server

[ Z ] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

    read -p 'Type Number | Press [ENTER]: ' typed </dev/tty

    case $typed in
    1)
        echo ""
        gcloud auth login --no-launch-browser --verbosity error --quiet
        echo "NOT-SET" >/var/plexguide/project.id
        echo "on" >/var/plexguide/project.switch
        ### note --no-user-output-enabled | gcloud auth login --enable-gdrive-access --brief
        # gcloud config configurations list
        gcestart
        ;;
    2)
        projectinterface
        gcestart
        ;;
    3)
        projectdeny
        processorcount
        gcestart
        ;;

    4)
        projectdeny
        ramcount
        gcestart
        ;;
    5)
        projectdeny
        nvmecount
        gcestart
        ;;
    6)
        projectdeny
        imagecount
        gcestart
        ;;
    7)
        projectdeny
        regioncenter
        gcestart
        ;;
    8)
        projectdeny
        deployserver
        gcestart
        ;;
    9)
        projectdeny
        if [[ "$gcedeployedcheck" == "DEPLOYED" ]]; then
            sshdeploy
        else
            gcestart
        fi
        ;;
    A)
        projectdeny
        destroyserver
        gcestart
        ;;
    a)
        projectdeny
        destroyserver
        gcestart
        ;;
    c)
	    calculator
        gcestart
        ;;
    C)
		calculator
        gcestart
        ;;
    z)
        exit
        ;;
    Z)
        exit
        ;;
    *)
        gcestart
        ;;
    esac
}
sudocheck
gcestart
