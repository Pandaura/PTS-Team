#!/bin/bash
#
# Title:      G/TDrive used space
# Coder: 	  MrDoob
# GNU:        General Public License v3.0
################################################################################
#functions
config="/opt/appdata/plexguide/rclone.conf"
log="/var/plexguide"
useragent="$(cat /var/plexguide/uagent)"

#if else loop for checking what is running
    rm -f $log/gdcrypt.log && touch $log/gdcrypt.log
    rm -f $log/tdcrypt.log && touch $log/tdcrypt.log
    rm -f $log/gduncrypt.log && touch $log/gduncrypt.log
    rm -f $log/tduncrypt.log && touch $log/tduncrypt.log

if grep -q "gdrive:" $config; then
    rclone size gdrive: \
        --verbose=1 \
        --fast-list \
        --retries 3 \
        --no-update-modtime \
        --user-agent="$useragent" \
        --timeout=30m \
        --exclude="**encrypt**" \
        --config /opt/appdata/plexguide/rclone.conf | awk '{print $3,$4}' >$log/gduncrypt.log
    sed -i 's/Total size: / /g' $log/gduncrypt.log
else echo "🔴 NOT DEPLOYED" $log/gduncrypt.log; fi

sleep 2

if grep -q "tdrive:" $config; then
    rclone size tdrive: \
        --verbose=1 \
        --fast-list \
        --retries 3 \
        --no-update-modtime \
        --user-agent="$useragent" \
        --timeout=30m \
        --exclude="**encrypt**" \
        --config /opt/appdata/plexguide/rclone.conf | awk '{print $3,$4}' >$log/tduncrypt.log
    sed -i 's/Total size: / /g' $log/tduncrypt.log
else echo "🔴 NOT DEPLOYED" $log/tduncrypt.log; fi

sleep 2

if grep -q "gcrypt:" $config; then
    rclone size gcrypt: \
        --verbose=1 \
        --fast-list \
        --retries 3 \
        --user-agent="$useragent" \
        --no-update-modtime \
        --timeout=30m \
        --config /opt/appdata/plexguide/rclone.conf | awk '{print $3,$4}' >$log/gdcrypt.log
    sed -i 's/Total size: / /g' $log/gdcrypt.log
else echo "🔴 NOT DEPLOYED" $log/gdcrypt.log; fi

sleep 2

if grep -q "tcrypt:" $config; then
    rclone size tcrypt: \
        --verbose=1 \
        --fast-list \
        --retries 3 \
        --user-agent="$useragent" \
        --no-update-modtime \
        --timeout=30m \
        --config /opt/appdata/plexguide/rclone.conf | awk '{print $3,$4}' >$log/tdcrypt.log
    sed -i 's/Total size: / /g' $log/tdcrypt.log
else echo "🔴 NOT DEPLOYED" $log/tdcrypt.log; fi