# Full System Backup with Rsync

#!/bin/bash

BACKUP_DIR="/mnt/backup"
EXCLUDE="/path/to/exclude.txt"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

rsync -av --exclude-from="$EXCLUDE" / "$BACKUP_DIR/system_backup_$TIMESTAMP"

echo "System backup completed at $BACKUP_DIR/system_backup_$TIMESTAMP"

# The exclude.txt file should contain directories to ignore (e.g., /proc, /sys, /dev).