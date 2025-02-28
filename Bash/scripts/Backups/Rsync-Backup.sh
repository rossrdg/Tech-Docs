# Rsync Backup Script (Incremental Backup)

#!/bin/bash

SOURCE="/path/to/source"
DESTINATION="/path/to/backup"
LOGFILE="/var/log/backup.log"

# Create a backup using rsync
rsync -av --delete "$SOURCE" "$DESTINATION" >> "$LOGFILE" 2>&1

echo "Backup completed on $(date)" >> "$LOGFILE"


# -a : Archive mode (preserves file permissions, timestamps, etc.).
# -v : Verbose output.
# --delete : Deletes files in the destination that no longer exist in the source.