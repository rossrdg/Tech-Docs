# Automated Disk Cleanup. This script automatically removes old log files to free up space.

#!/bin/bash

LOG_DIR="/var/log"
DAYS=7
find $LOG_DIR -type f -name "*.log" -mtime +$DAYS -exec rm -f {} \;



