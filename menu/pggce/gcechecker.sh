#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
touch /var/plexguide/gce.done
### NOTE THIS IS JUST A COPY - MAIN ONE SITE IN MAIN REPO - THIS IS JUST FOR INFO
gcheck=$(dnsdomainname | tail -c 10)
file1="/dev/nvme0n1"
file2="/var/plexguide/gce.check"

  if [[ $EUID -ne 0 ]]; then
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  You Must Execute as a SUDO USER (with sudo) or as ROOT!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    exit 1
  fi

file3="$(tail -n 1 /var/plexguide/gce.done)"
file3b="/var/plexguide/gce.done"

if [[ "$file3" == "1" ]]; then
		  tee <<-EOF
	━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	📂  Google Cloud Feeder Edition SET!
	━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	
     NVME already mounted on /mnt with size $(df -h /mnt/ --total --local -x tmpfs | grep 'total' | awk '{print $2}')
	━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	EOF
 exit
 
elif [[ "$file3" != "1" ]]; then

	if [ "$gcheck" == ".internal" ]; then
		  tee <<-EOF

	━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	📂  Google Cloud Feeder Edition SET!
	━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

	⚡  Google Cloud Instance Detected!

	⚠️  NOTE: Setting Up the NVME Drive For You! Please Wait!
	⚠️  NOTE: Please don't close it !

	━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

	EOF
		  apt-get install mdadm --no-install-recommends -yqq 2>&1 >>/dev/null
		  export DEBIAN_FRONTEND=noninteractive
		  #Check for NVME
		  lsblk | grep nvme | awk '{print $1}' >/var/plexguide/nvme.log
		  lsblk | grep nvme | awk '{print $1}' >/var/plexguide/nvmeraid.log
		  sed -i 's/nvme0n//g' /var/plexguide/nvmeraid.log
		  #Check for NVME
		  nvme="$(tail -n1 /var/plexguide/nvmeraid.log)"

		  if [[ "$nvme" == "2" ]]; then
				mdadm --create /dev/md0 --level=0 --raid-devices=2 /dev/nvme0n1 /dev/nvme0n2
				mkfs.ext4 -F /dev/md0
				mkdir -p /mnt
				mount /dev/md0 /mnt
				sed -i '$ a\/dev/md0 /mnt ext4 discard,defaults,nobarrier,nofail 0 0' /etc/fstab
				chown -cR 1000:1000 /mnt
				tune2fs -m 0 /dev/md0
				echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
				echo "✅ PASSED ! NVME RAID0 Creator with 2 NVMEs as RAID0  - finish"
				echo "✅ PASSED ! HDD Space now :" $(df -h /mnt/ --total --local -x tmpfs | grep 'total' | awk '{print $2}')
				echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
				echo -e "1" >/var/plexguide/gce.done
				sleep 2
		  elif [[ "$nvme" == "3" ]]; then
				mdadm --create /dev/md0 --level=0 --raid-devices=3 /dev/nvme0n1 /dev/nvme0n2 /dev/nvme0n3
				mkfs.ext4 -F /dev/md0
				mkdir -p /mnt
				mount /dev/md0 /mnt
				sed -i '$ a\/dev/md0 /mnt ext4 discard,defaults,nobarrier,nofail 0 0' /etc/fstab
				chown -cR 1000:1000 /mnt
				tune2fs -m 0 /dev/md0
				echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
				echo "✅ PASSED ! NVME RAID0 Creator with 3 NVMEs as RAID0 - finish"
				echo "✅ PASSED ! HDD Space now :" $(df -h /mnt/ --total --local -x tmpfs | grep 'total' | awk '{print $2}')
				echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
				echo -e "1" >/var/plexguide/gce.done
				sleep 2
		  elif [[ "$nvme" == "4" ]]; then
				mdadm --create /dev/md0 --level=5 --raid-devices=4 /dev/nvme0n1 /dev/nvme0n2 /dev/nvme0n3 /dev/nvme0n4
				mkfs.ext4 -F /dev/md0
				mkdir -p /mnt
				mount /dev/md0 /mnt
				sed -i '$ a\/dev/md0 /mnt ext4 discard,defaults,nobarrier,nofail 0 0' /etc/fstab
				chown -cR 1000:1000 /mnt
				tune2fs -m 0 /dev/md0
				echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
				echo "✅ PASSED ! NVME RAID0 Creator with 4 NVMEs as RAID5 - finish"
				echo "✅ PASSED ! HDD Space now :" "$(df -h /mnt/ --total --local -x tmpfs | grep 'total' | awk '{print $2}')"
				echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
				sleep 2
				echo -e "1" >/var/plexguide/gce.done
		  elif [[ "$nvme" == "1" ]]; then
				sleep 3
				mkfs.ext4 -F /dev/nvme0n1 1>/dev/null 2>&1
				mount -o discard,defaults,nobarrier /dev/nvme0n1 /mnt
				chmod a+w /mnt 1>/dev/null 2>&1
				echo UUID=$(blkid | grep nvme0n1 | cut -f2 -d'"') /mnt ext4 discard,defaults,nobarrier,nofail 0 2 | tee -a /etc/fstab
				echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
				echo "✅ PASSED ! NVME formated and setup is done"
				echo "✅ PASSED ! HDD Space now :" $(df -h /mnt/ --total --local -x tmpfs | grep 'total' | awk '{print $2}')
				echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
				echo -e "1" >/var/plexguide/gce.done
		  else
				echo "nothing to do"
		  fi

		  touch /var/plexguide/gce.check
		  rm -rf /var/plexguide/gce.failed 1>/dev/null 2>&1
		  rm -rf /var/plexguide/gce.false 1>/dev/null 2>&1
		  rm -rf /var/plexguide/nvme.log 1>/dev/null 2>&1
		  rm -rf /var/plexguide/nvmeraid.log 1>/dev/null 2>&1

		  echo "feeder" >/var/plexguide/pg.server.deploy
		  cat /var/plexguide/pg.edition >/var/plexguide/pg.edition.stored

		  tee <<-EOF

	━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	📂  GCE Harddrive Deployed!
	━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

	⚡  Automatically Setting Google Feeder Edition (GCE)

	⚠️  Please Wait!

	━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

	EOF

		  sleep 6
	elif [ ! -e "$file1" ] && [ ! -e "$file2" ] && [ "$gcheck" == ".internal" ]; then
		  tee <<-EOF

	━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
	📂  Google Cloud Feeder Edition Failed!
	━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

	⚡  Google Cloud Instance Detected, but you Failed to setup an NVME
	   drive per the wiki! This mistake only occurs on manual GCE
	   deployments. Most likely you setup an SSD instead! The install will
	   continue, but this will fail! Wipe the box and setup again with an
	   NVME Drive!

	━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

	EOF
		  read -p 'Press [ENTER] to Continue! ' typed </dev/tty
		  rm -rf /var/plexguide/gce.failed 1>/dev/null 2>&1
		  rm -rf /var/plexguide/gce.false 1>/dev/null 2>&1
		  rm -rf /var/plexguide/nvme.log 1>/dev/null 2>&1
		  rm -rf /var/plexguide/nvmeraid.log >/dev/null 2>&1
	else
		  touch /var/plexguide/gce.false
    fi
else 
echo "beware of this stupid lines"

fi
