#!/bin/bash
#
# docker autoprune unused docker/ volumes 
################################################################################
#echo "[$(date)] Docker Cleanup starting." >>/var/plexguide/docker-cleanup.log
#docker system prune --volumes -a -f >>/var/plexguide/docker-cleanup.log
#docker image prune -a -f >>/var/plexguide/docker-cleanup.log
#docker volume rm $(docker volume ls -qf dangling=true) >>/var/plexguide/docker-cleanup.log
#echo "[$(date)] Docker Cleanup has completed." >>/var/plexguide/docker-cleanup.log
#########################################
echo "[$(date)] Docker Cleanup starting." >>/var/plexguide/docker-cleanup.log
docker=$(docker volume ls -qf dangling=true | wc -l)
if [[ "$docker" -eq "1" ]]; then
   if [[ "$docker" -gt "0" ]]; then
      echo "Cleaning up Docker dangling volumes." >>/var/plexguide/docker-cleanup.log
      docker volume rm $(docker volume ls -qf dangling=true) >>/var/plexguide/docker-cleanup.log
      #docker image prune -a -f  >>/var/plexguide/docker-cleanup.log
      docker system prune --volumes -a -f >>/var/plexguide/docker-cleanup.log
   else
      echo "No Docker dangling volumes found." >>/var/plexguide/docker-cleanup.log
   fi
fi
echo "[$(date)] Docker Cleanup has completed." >>/var/plexguide/docker-cleanup.log
