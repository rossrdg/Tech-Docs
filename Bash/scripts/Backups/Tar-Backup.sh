# Tar Backup Script (Compressed Archive)

#!/bin/bash

BACKUP_DIR="/path/to/backup"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
ARCHIVE_NAME="backup_$TIMESTAMP.tar.gz"
SOURCE="/path/to/source"

tar -czf "$BACKUP_DIR/$ARCHIVE_NAME" "$SOURCE"

echo "Backup created at $BACKUP_DIR/$ARCHIVE_NAME"

# tar -czf : Creates a compressed archive.
# date +"%Y-%m-%d_%H-%M-%S" : Adds a timestamp to the backup file.