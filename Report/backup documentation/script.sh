#!/bin/bash
SERVER_IP="54.82.198.169"
REMOTE_USER="ubuntu"
MONGODUMP_PATH="/usr/bin/mongodump"
BACKUPS_DIR="/home/ubuntu/dump/"
FILENAME_TIME=`date +"%Y%m%dT%H%M"`
NUMBER_OF_ALLOWED_BACKUPS=5

cd /home/student/Desktop/script
# SSH and create dump for nodebb database

ssh ubuntu@54.82.198.169 mongodump -d nodebb

# Create directory for the current backup
mkdir -p local-backups/$FILENAME_TIME
# Fetch
#scp -pr $REMOTE_USER@$SERVER_IP:$BACKUPS_DIR
scp -pr ubuntu@54.82.198.169:/home/ubuntu/dump /home/student/Desktop/script/local-backups/$FILENAME_TIME

# Remove
ssh $REMOTE_USER@$SERVER_IP rm -rf $BACKUPS_DIR
### Check number of backups in the directory

NUMBER_OF_BACKUPS=`ls local-backups/ | wc -l`
# ls local-backups/ | wc -l
echo "=================================================================="
echo "There are $NUMBER_OF_BACKUPS backups available in the local backup folder."
echo "=================================================================="
# List all backup files
cd local-backups
ls
# Delete least recent if larger than 5 backups
if (($NUMBER_OF_BACKUPS > $NUMBER_OF_ALLOWED_BACKUPS));
then
	echo "=================================================================="
        echo "New backup with name: $FILENAME_TIME is backup up."
	echo "There are more than $NUMBER_OF_ALLOWED_BACKUPS backups. Deleting least recent:"
	ls -t | tail -1
	rm -rf "$(ls -t | tail -1)"
	echo "...."
else
	echo "New backup with name: $FILENAME_TIME is backed up."
fi
