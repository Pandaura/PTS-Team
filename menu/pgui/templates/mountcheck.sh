#!/bin/bash
#
# Title:      PTS Community 
# Author:     MrDoob
# URL:        WTFH >-!-< why you need this ^^ 
# GNU:        General Public License v3.0
#
################################################################################

mountcheckloop() {
while true; do
	rm -rf /opt/appdata/plexguide/emergency/*
	mkdir -p /opt/appdata/plexguide/emergency
	gdrivecheck=$(systemctl is-active gdrive)
	gcryptcheck=$(systemctl is-active gcrypt)
	tdrivecheck=$(systemctl is-active tdrive)
	tcryptcheck=$(systemctl is-active tcrypt)
	pgunioncheck=$(systemctl is-active pgunion)
    pgblitzcheck=$(systemctl is-active pgblitz)
    pgmovecheck=$(systemctl is-active pgmove)

    pgblitz=$(systemctl list-unit-files | grep pgblitz.service | awk '{ print $2 }')
    pgmove=$(systemctl list-unit-files | grep pgmove.service | awk '{ print $2 }')
    upper=$(docker ps --format '{{.Names}}' | grep "uploader")
    uppercheck="/opt/appdata/uploader/"

	rm -rf /var/plexguide/pg.blitz && touch /var/plexguide/pg.blitz
       
	   if [[ "$pgmove" == "enabled" ]]; then
           if [[ "$pgmovecheck" != "active" ]]; then
              echo " 🔴 MOVE" >/var/plexguide/pg.blitz
           else echo " ✅ MOVE" >/var/plexguide/pg.blitz; fi
        elif [[ "$pgblitz" == "enabled" ]]; then
           if [[ "$pgblitzcheck" != "active" ]]; then
              echo " 🔴 BLITZ" >/var/plexguide/pg.blitz
                else echo " ✅ BLITZ" >/var/plexguide/pg.blitz; fi
	    elif [[ -d "$uppercheck" ]]; then
		   if [[ "$upper" == "uploader" ]]; then
              echo " ✅ Uploader" >/var/plexguide/pg.blitz
                else echo " 🔴 Uploader" >/var/plexguide/pg.blitz; fi
        else echo " 🔴 Not Operational UPLOADER" >/var/plexguide/pg.blitz
        fi

	    rm -rf /var/plexguide/pg.blitz && touch /var/plexguide/pg.blitz
	    if [[ "$upper" == "uploader" ]]; then
           echo " ✅ Uploader" >/var/plexguide/pg.blitz
        else echo " 🔴 Uploader" >/var/plexguide/pg.blitz; fi


		config="/opt/appdata/plexguide/rclone.conf"
		if grep -q "gdrive" $config; then
			  if [[ "$gdrivecheck" != "active" ]]; then
				echo " ⚠ " >/var/plexguide/pg.gdrive
			  else echo " ✅ " >/var/plexguide/pg.gdrive; fi
		else echo " 🔴 " >/var/plexguide/pg.gdrive; fi
		if grep -q "gcrypt" $config; then
			  if [[ "$gcryptcheck" != "active" ]]; then
				echo " ⚠ " >/var/plexguide/pg.gcrypt
			  else echo " ✅ " >/var/plexguide/pg.gcrypt; fi
		else echo " 🔴 " >/var/plexguide/pg.gcrypt; fi
		if grep -q "tdrive" $config; then
			  if [[ "$tdrivecheck" != "active" ]]; then
				echo " ⚠ " >/var/plexguide/pg.tdrive
			  else echo " ✅ " >/var/plexguide/pg.tdrive; fi
		else echo " 🔴 " >/var/plexguide/pg.tdrive; fi
		if grep -q "tcrypt" $config; then
			  if [[ "$tcryptcheck" != "active" ]]; then
				echo " ⚠ " >/var/plexguide/pg.tcrypt
			  else echo " ✅ " >/var/plexguide/pg.tcrypt; fi
		else echo " 🔴 " >/var/plexguide/pg.tcrypt; fi
		if grep -q "pgunion" $config; then
			  if [[ "$pgunioncheck" != "active" ]]; then
				echo " ⚠ " >/var/plexguide/pg.union
			  else echo " ✅ " >/var/plexguide/pg.union; fi
		else echo " 🔴 " >/var/plexguide/pg.union; fi
  # Disk Calculations - 5000000 = 5GB
  leftover=$(df / --local | tail -n +2 | awk '{print $4}')
	diskspace27=0
  if [[ "$leftover" -lt "5000000" ]]; then
    diskspace27=1
    echo "Emergency: Primary DiskSpace Under 5GB - Stopped Downloading Programs (i.e. NZBGET, RuTorrent)" >/opt/appdata/plexguide/emergency/message.1
    docker stop nzbget 1>/dev/null 2>&1
    docker stop sabnzbd 1>/dev/null 2>&1
    docker stop rutorrent 1>/dev/null 2>&1
    docker stop deluge 1>/dev/null 2>&1
    docker stop qbittorrent 1>/dev/null 2>&1
    docker stop deluge-vpn 1>/dev/null 2>&1
    docker stop transmission 1>/dev/null 2>&1
    docker stop rflood-vpn 1>/dev/null 2>&1
    docker stop rutorrent-vpn 1>/dev/null 2>&1
    docker stop transmission-vpn 1>/dev/null 2>&1
    docker stop jdownloader2 1>/dev/null 2>&1
    docker stop jd2-openvpn 1>/dev/null 2>&1
  elif [[ "$leftover" -gt "3000000" && "$diskspace27" == "1" ]]; then
    docker start nzbget 1>/dev/null 2>&1
    docker start sabnzbd 1>/dev/null 2>&1
    docker start rutorrent 1>/dev/null 2>&1
    docker start deluge 1>/dev/null 2>&1
    docker start qbittorrent 1>/dev/null 2>&1
    docker start deluge-vpn 1>/dev/null 2>&1
    docker start transmission 1>/dev/null 2>&1
    docker start rflood-vpn 1>/dev/null 2>&1
    docker start rutorrent-vpn 1>/dev/null 2>&1
    docker start transmission-vpn 1>/dev/null 2>&1
    docker start jdownloader2 1>/dev/null 2>&1
    docker start jd2-openvpn 1>/dev/null 2>&1
    rm -rf /opt/appdata/plexguide/emergency/message.1
    diskspace27=0
  fi
  ##### Warning for Ports Open with Traefik Deployed
  if [[ $(cat /var/plexguide/pg.ports) != "Closed" && $(docker ps --format '{{.Names}}' | grep "traefik") == "traefik" ]]; then
    echo "Warning: Traefik deployed with ports open! Server at risk for explotation!" >/opt/appdata/plexguide/emergency/message.a
  elif [[ -e "/opt/appdata/plexguide/emergency/message.a" ]]; then rm -rf /opt/appdata/plexguide/emergency/message.a; fi

  if [[ $(cat /var/plexguide/pg.ports) == "Closed" && $(docker ps --format '{{.Names}}' | grep "traefik") == "" ]]; then
    echo "Warning: Apps Cannot Be Accessed! Ports are Closed & Traefik is not enabled! Either deploy traefik or open your ports (which is worst for security)" >/opt/appdata/plexguide/emergency/message.b
  elif [[ -e "/opt/appdata/plexguide/emergency/message.b" ]]; then rm -rf /opt/appdata/plexguide/emergency/message.b; fi
  ##### Warning for Bad Traefik Deployment - message.c is tied to traefik showing a status! Do not change unless you know what your doing
  touch /opt/appdata/plexguide/traefik.check
  domain=$(cat /var/plexguide/server.domain)
  cname="portainer"
  if [[ -f "/var/plexguide/portainer.cname" ]]; then
    cname=$(cat "/var/plexguide/portainer.cname")
  fi
  wget -q "https://${cname}.${domain}" -O "/opt/appdata/plexguide/traefik.check"
  if [[ $(cat /opt/appdata/plexguide/traefik.check) == "" && $(docker ps --format '{{.Names}}' | grep "traefik" ) == "traefik" ]]; then
    echo "Traefik is Not Deployed Properly! Cannot Reach the Portainer SubDomain!" >/opt/appdata/plexguide/emergency/message.c
  else
    if [[ -e "/opt/appdata/plexguide/emergency/message.c" ]]; then
      rm -rf /opt/appdata/plexguide/emergency/message.c
    fi
  fi
  ##### Warning for Traefik Rate Limit Exceeded
  if [[ $(cat /opt/appdata/plexguide/traefik.check) == "" && $(docker logs traefik | grep "rateLimited") != "" ]]; then
    echo "$domain's rated limited exceed | Traefik (LetsEncrypt)! Takes upto one week to clear up (or use a new domain)" >/opt/appdata/plexguide/emergency/message.d
  else
    if [[ -e "/opt/appdata/plexguide/emergency/message.d" ]]; then
      rm -rf /opt/appdata/plexguide/emergency/message.d
    fi
  fi
 ##################
sleep 2
  ################# Generate Output
  echo "" >/var/plexguide/emergency.log
  if [[ $(ls /opt/appdata/plexguide/emergency) != "" ]]; then
    countmessage=0
    while read p; do
      let countmessage++
      echo -n "${countmessage}. " >>/var/plexguide/emergency.log
      echo "$(cat /opt/appdata/plexguide/emergency/$p)" >>/var/plexguide/emergency.log
    done <<<"$(ls /opt/appdata/plexguide/emergency)"
  else
    echo "NONE" >/var/plexguide/emergency.log
  fi
sleep 15
done
}

# keeps the function in a loop
mountcheckloop=0
while [[ "$mountcheckloop" == "0" ]]; do mountcheckloop; done