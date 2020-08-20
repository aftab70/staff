####################################################################################################################################################################

Live_mariadb_backup





#!/bin/bash
set -x
set -e

NOW="$(date +"%d-%m-%Y")"

ssh -i '/home/ginger/Documents/Live_Deploy_Azure/comet.pem' comet@52.172.143.38 << EOF
sh  /home/comet/Documents/mariadb_backup_script.sh
export NOW=$NOW
cd /mnt/Mariadb_Backup
tar -czvf mariadb_backup_$NOW.tar.gz $NOW
find /mnt/Mariadb_Backup -mtime +3 -prune -exec rm -rf '{}' \; 
EOF

mkdir /home/ginger/Documents/Live_Mariadb_Backup/$NOW
scp -r -i "/home/ginger/Documents/Live_Deploy_Azure/comet.pem" comet@52.172.143.38:/mnt/Mariadb_Backup/mariadb_backup_$NOW.tar.gz  /home/ginger/Documents/Live_Mariadb_Backup/$NOW
scp -r /home/ginger/Documents/Live_Mariadb_Backup/$NOW ginger@192.168.0.231:/home/ginger/Documents/Live_Mariadb_Backup/

find /home/ginger/Documents/Live_Mariadb_Backup -mtime +10 -prune -exec rm -rf '{}' \;

####################################################################################################################################################################
