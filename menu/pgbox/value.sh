#!/bin/bash
#
# Title:      Value for all apps CORE / COMM and MYContainer
# Author(s):  MrDoob
# GNU:        General Public License v3.0
################################################################################
#####FUNCTION 

app=$(cat /tmp/program_var)
##### CHECK START #####

if [ "$app" == "plex" ]; then
     bash /opt/plexguide/menu/plex/plex.sh ; fi

if [ "$app" == "plaxt" ]; then
     bash /opt/plexguide/menu/pgbox/customparts/plaxt.sh; fi

if [ "$app" == "channelsdvr" ]; then
     bash /opt/plexguide/menu/pgbox/customparts/channelsdvr.sh; fi

if [ "$app" == "rclonegui" ]; then
     bash /opt/plexguide/menu/pgbox/customparts/rclonegui.sh; fi

if [ "$app" == "varken" ]; then
     bash /opt/plexguide/menu/pgbox/customparts/geolite.sh; fi

##### CHECK EXIT #####
