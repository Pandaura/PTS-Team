![](https://github.com/Pandaura/PTS-Team/blob/master/pandaura.gif)  

THIS KINDA EXPLODED SOMEWHAT SO EXPECT TO SEE SOME CHANGES SOON! BARE WITH ME!

This is a fork of PTS/MHA called Pandaura. Thank you to all who contributed to the previous projects. No features are really added to MHA anymore as it is in maintenance mode so I will be making some ammendments here. Pandaura utilizes Ansible and Docker to streamline your media server while deploying multiple tools for your server operations.

My personal opinion. PTS/MHA did well and still are providing excellend support. Whilst PG was more of a rename and grab project with an awesome community in which we can't deny the time and effort that was put into the project. The remnants meant things were, for lack of a better word, bashed together which left untidy and unfinished menu systems with grammar and spelling that will make your eyes bleed. I'm here to tidy this up, improve on the messy (only in some places) code and just make this the tool that it should have been. Previous projects had the potential to just be burned but you have nothing to worry about here. This is a safer/faster/more reliable project but we all have different tastes....enjoy.

I'll be listing a few of the annoyances below...

The menu doesn't even go back when you're in a sub menu half the time...you are either left hanging or you go straight back to the beginning either way this is really frustrating

Most menu sub systems again wouldn't even 'clear' leaving your terminal messy

Current section being worked on - 

Traefik V2  
Authelia  
Cloud Companion  
Python Plex Library - own version with scraping 
Spelling/typos/general script tidy up  
Refresh  
Ouroboros -- It's no longer in development so why use it https://github.com/pyouroboros/ouroboros  
Core Apps - Update the list of Core apps  
Community Apps - Update the list of Community apps  

_**Table of Contents**_

1. [Install](#1-install)
2. [Project Statement](#2-project-statement)
3. [Functional Use](#3-functional-use)
4. [Recommended Reading](#5-recommended-reading)
5. [Having Issues?](#6-having-issues)

----

# 1. Install

## (i) Backup your current server using PTS Vault before installing Pandaura.   

Your PTS backup can be used to restore your applications in Pandaura fork after install (see later)  
**NOTE**  Tested and working for PG v8.5-8.7

Type the following to access your current build's menu: `sudo pgblitz`    
Select  `[7] PG vault [Backup & Restore]`  then  
Select  `[1] Utilize PG Vault`  then  
Select  `[1] Data Backup`

At this stage you can either type `all` (to backup all apps) OR `appname` (to queue/stack apps which you would like to backup) followed by typing `A`.  


**IMPORTANT**
If you have an encrypted drive and have forgotten, not documented or not backed up your SALT/password for PG Clone, you should at this stage also backup your keys/rclone.config to gdrive. This can be done by the following:  

Type or paste the following to backup your keys:
```
sudo wget -N https://raw.githubusercontent.com/MHA-Team/PTS-Clone/final/functions/backup-keys.sh

```  


## (ii) Installing Pandaura

**NOTE**
The ideal method of installing the Pandaura is to delete your current build and install Pandaura on a clean system.
Pandaura works best on **ubuntu 18.XX** and this tutorial will assume you are using ubuntu 18.XX.
If you are unsure on how to do this, please refer to the documentation provided by your server provider.  

Once your server has an OS installed, login to your server using SSH.  

Type or paste the following to install Pandaura fork:  

```
sudo apt-get update -yqq
sudo apt-get upgrade -yqq
sudo apt-get autoclean -yqq
sudo apt-get install wget -y
sudo wget -qO- https://raw.githubusercontent.com/Pandaura/Install/master/install.sh | sudo bash

```

The installation will then take you through the setup which is self-explanatory.  

### Optional - updating your PTS to Pandaura
IDoMnCi came up with a great script to change all the links on an existing PTS-Team (NOT PG 8.x) to the Pandaura.
Details - https://github.com/Pandaura/Install/pull/4
```
sudo wget -qO- https://raw.githubusercontent.com/Pandaura/Install/master/relocate.sh | sudo bash

sudo ptsupdate

```

## Configuring Pandaura

Then type the following to run the Pandaura menu: `sudo pandaura`

* Set up and deploy Traefik ([see here](https://github.com/Pandaura/PTS-Team/wiki/Traefik))   

* Close ports using Port Guard ([see here](https://github.com/Pandaura/PTS-Team/wiki/PTS-Port-Guard))  

* Deploy Pandaura Shield (GOAuth - all apps supported) [see here](https://github.com/Pandaura/PTS-Team/wiki/PTS-Shield)

* Set up and deploy Clone. You can restore you backup keys at this stage. [see here](https://github.com/Pandaura/PTS-Team/wiki/PTS-Clone)

* (Optional) Restore PTS backup (created in step 1) using Vault. [see here](https://github.com/Pandaura/PTS-Team/wiki/PTS-Vault---Data-Storage)

* Install desired core/community applications (Do this regardless of whether it is a fresh install with restore or overwrite)  [see here](https://github.com/Pandaura/PTS-Team/wiki/core-apps)

* (Optional) If overwriting/restoring, you will need to change 2 remote path mappings in applications (NZB clients / Torrent clients / radarr / sonarr / lidarr etc)    [see here](https://github.com/Pandaura/PTS-Team/wiki/Remote-Path-Mappings)

**Why do I need to change remote paths?**  

Pandaura will create one download folder for completed downloads using any NZB client `/mnt/downloads/nzb` and one download folder for completed downloads using any torrent client `/mnt/downloads/torrent`. Both folder names are different to those used in previous versions of PTS. This remote paths need to be changed in your configuration settings (nzbget/radarr/sonarr etc) which you can do in either in terminal or webUI.  

**NOTE**  PTS does **not** install PGUI by default.   

# 2. Project Statement

Pandaura  is a **fork** of PTS/MHA, an all-in-one media solution that deploys a Media Server through the use of either your local HDD or Google Drive; serving as unlimited back-end storage.

# 3. Functional Use

1. Deploys multiple programs/apps and functional within 10 - 30 seconds
1. Deploy PTS on a remote machine, local machine, VPS, or virtual machines
1. Deploy PTS utilizing Google's GSuite for unlimited space or through the solo or multiple HD editions
1. Deploys a Reverse Proxy (Traefik) so you can obtain https:// certificates on all your containers
1. Backup and Restore data through your Google Drive
1. Aligns data and ports for efficiency
1. Deploys with a simple installer and a GUI like interface (commands do not have to be typed out)

.....

# 4. Recommended Reading

[**[Click Here]**](https://github.com/Pandaura/PTS-Team/wiki/Pre-Reading) to view the list!

## 5. Having Issues?

[**[Click Here]**](https://github.com/Pandaura/PTS-Team/wiki/Common-Issues) for more information!
