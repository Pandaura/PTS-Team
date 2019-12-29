#!/bin/bash

test="/opt/appdata/plexguide/rclone.conf"
log="/var/plexguide"


if grep -q "gdrive:" $test ; then
rclone dedupe gdrive: \
 --dedupe-mode largest \
 --verbose=1 \
 --fast-list \
 --retries 3 \
 --no-update-modtime \
 --user-agent="gdrivedupe" \
 --timeout=30m \
 --config /opt/appdata/plexguide/rclone.conf >> $log/gduncrypt-dupe.log
fi

if grep -q "tdrive:" $test ; then
 rclone dedupe tdrive: \
 --dedupe-mode largest \
 --verbose=1 \
 --fast-list \
 --retries 3 \
 --no-update-modtime \
 --user-agent="tdrivedupe" \
 --timeout=30m \
 --config /opt/appdata/plexguide/rclone.conf >> $log/dupe-tduncrypt.log
fi

if grep -q "gcrypt:" $test ; then
rclone dedupe gcrypt: \
 --dedupe-mode largest \
 --verbose=1 \
 --fast-list \
 --retries 3 \
 --user-agent="grcyptspace" \
 --no-update-modtime \
 --timeout=30m \
 --config /opt/appdata/plexguide/rclone.conf >> $log/dupe-gdcrypt.log
fi

if grep -q "tcrypt:" $test ; then
rclone dedupe tcrypt: \
 --dedupe-mode largest \
 --verbose=1 \
 --fast-list \
 --retries 3 \
 --user-agent="tcryptdupe" \
 --no-update-modtime \
 --timeout=30m \
 --config /opt/appdata/plexguide/rclone.conf >> $log/dupe-tdcrypt.log
fi
