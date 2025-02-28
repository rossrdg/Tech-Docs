# SCP/SSH Remote Backup Script

#!/bin/bash

SOURCE="/path/to/source"
REMOTE_USER="username"
REMOTE_HOST="your.server.com"
REMOTE_DIR="/remote/backup/location"

scp -r "$SOURCE" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR"

echo "Backup transferred to $REMOTE_HOST:$REMOTE_DIR"

