# MySQL Database Backup (For Web Servers)

#!/bin/bash

DB_USER="root"
DB_PASSWORD="yourpassword"
DB_NAME="yourdatabase"
BACKUP_DIR="/path/to/backup"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" > "$BACKUP_DIR/db_backup_$TIMESTAMP.sql"

echo "Database backup completed at $BACKUP_DIR/db_backup_$TIMESTAMP.sql"
