
## Unreleased 1.0.5 (date)

### New Features

### Improvements
- added self test to the config screen for plex_autoscan.

### Fixes
- plex_autoscan config improvements, still needs more work but should be a little more robust now.

-----

## Pre 1.0.5 changelog.

**WIKI will updated soon**
Update PTS from 22.10.2018

**PTS_Install**
* install.sh used now more ansible 
* aliase role added
* folder role added
* systemtweak role added

# 
Update PTS from 19.10.2018

**BASE_System**
* Processing disk part changed and fixxed
* PGUI Switch command fixed ( read and executed now the right files )
* PGUI Switch _ print now [ open or closed Ports ] + PGUI - domain 
* is Domain not set ->
```
[6] Comm UI          :  [ On ] | Port [ 8555 ] | **pgui.NOT-SET**
```
is Domain set -> 
```
[6] Comm UI          :  [ On ] | Port [ 8555 ] | **pgui.print-domain.com**
```

* is port status  CLOSED ->
```
[6] Comm UI          :  [ On ] | Port [ **CLOSED** ] | pgui.NOT-SET
```
* is port status  OPEN ->
```
[6] Comm UI          :  [ On ] | Port [ **8555 **] | **pgui.print-domain.com**
```

**rClone**
* small updates in cloneclean.sh 
* variable set ( uaganet automatic create random agent for first install )
* cloneclean preset to 600min 
* cloneclean.sh fixed ; remove empty folder in "$hdpath/move"

**PTS Vault**
* used the VFS Settings / useragent now



***

Update PTS from 16.10.2019

**rClone:**
*  mounts  fixxed ( sorry )

**MAIN - SYSTEM**
* mot.d : 
1. hostname print as header ( colored )
2. Space - local and Space - Cloud edit
* remove qoute ( old shit part ) and replay with /usr/games/fortune -as 
* new command : autobackup
* Layout edit ( interface )


**Vault**
* autobackup add

**Install:**
* small fix for install 

**Core Apps**
* rtorrent -main stage fixxed 


***

Update PTS from 15.10.2019
**

* Traefik : untouched
* Shield : untouched


**MAIN - SYSTEM**
* mergerfs role fixxed 
* rclone role fixxed
* update role included 
* system update role included
* docker latest stable version install over role
* autmatic install journal role 
* automatic install mergerfs  ( latest release )
* autmatic install rclone ( latest release )



**rClone**
* backup & restore Keys and rclone.config in seperate folder on gdrive
* pgblitz / move added
```
 --exclude-from="/opt/appdata/plexguide/transport.exclude"
 --exclude-from="/opt/pgclone/excluded/excluded.folder"
````
* cloneclean  edit  = for catching the right folder 
* services gdrvie / tdrive --stats \ added
* Update gaccount.sh for first install
* update useraganet :  variable is 32 characters for no duplicates of agents
* automatic retrieng to mount GDrive / Tdrive and GCrypt / TCrypt 5x 
* automatic restarting docker after deploy new VFS Setting



**BASE-SYSTEM**
* small fixxes in the pts-function
* small fixxes in the install.sh
* docker role based for ubuntu & debian 
* small fix in mountcheck 
* removing the most Brandings
* google_cloud_sdk install over ansible role ( automatic )
* hetzner_cloud enige installed now the latest version ( automatic )


**APPS**
* all apps now support goauth
* downloader folder

**finished :**
* NZB clients = /mnt/downloands/nzb
* Torrent = /mnt/downloands/torrent

**Plex**
* support now LinuxServer:IO image
* Media Plugins added 
* HAMA / SONARR / RADARR autmatic installed over ansible
* Some DB edits =  db size to 2000

**rutorrent**
* downloasd going to /mnt/incomplete/torrent after finished automatic moved to /mnt/downloads/torrent/

**NZBGET**
* some pugins added 


**(( remote mapping ))**
* radarr / sonarr :
* one folder for NZB / torrent now 
* /mnt/downloads/nzb = all NZB clients **[ CORE APPS !! ]**
* /mnt/downloads/torrent = all torrent clients **[ CORE APPS !! ]**

**apps comm:**

* all apps support now GOauth
* Community UI edit | for list used spaces 
* Google Drive used space reloading daily

**short Commands**
* scommands add for list all possible commands | included infos now
* same short commands added 



**Vault**

* small fixxes for upload tweaking 
* useragent included now

**traktarr ( old pgtrakt )**

* max year from 2019 to 2050
* anime now possible
* commands are the same as before


**system tweaks**

* crontabs added

```
#Ansible: Build a Cron Job - Auto Prune
@daily prune 1>/dev/null 2>&1
#Ansible: Build a Cron Job - Journal Purge
@daily jpurge 1>/dev/null 2>&1
#Ansible: Build a Cron Job - Update Weekly
@weekly update 1>/dev/null 2>&1
#Ansible: Build a Cron Job - remove logs after reboot
@reboot kill_logs 1>/dev/null 2>&1
#Ansible: Build a Cron Job - remove logs daily
@daily kill_logs 1>/dev/null 2>&1
```
