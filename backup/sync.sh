#!/bin/bash
# Syncing files in ~/Backup/ to personal server
# Not using "archive" option as I don't want to save user/group, just timestamps. So I use "--times" option

LOCAL="$HOME/Backup/"
REMOTE="michael@michaelclaybaugh.com:Backup/"

check_backup_status () {
	rsync --recursive --verbose --times --human-readable  --update --dry-run \
		--exclude-from="exclude.txt" \
		$LOCAL $REMOTE
}

check_pull_status () {
	rsync --recursive --verbose --times --human-readable --update --dry-run  \
		--exclude-from="exclude.txt" \
		$REMOTE $LOCAL
}

backup_files () {
	rsync --recursive --verbose --times --human-readable \
		--exclude-from="exclude.txt" \
		$LOCAL $REMOTE
}

pull_files () {
	rsync --recursive --verbose --times --human-readable \
		--exclude-from="exclude.txt" \
		$REMOTE $LOCAL
}


read -p "Check pull status? [y/n]: " checkSync
if [ "$checkSync" == "y" ]; then
	check_pull_status
fi

read -p "Check backup status? [y/n]: " checkBackup
if [ "$checkBackup" == "y" ]; then
		check_backup_status
fi

read -p "Pull files? [y/n]: " pull
if [ "$pull" == "y" ]; then
	pull_files
fi

read -p "Backup files? [y/n]: " backup
if [ "$backup" == "y" ]; then
	backup_files
fi