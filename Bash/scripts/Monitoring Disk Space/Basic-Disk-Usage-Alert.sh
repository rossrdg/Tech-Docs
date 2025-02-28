# Basic Disk Usage Alert Script. This simple script checks disk usage and sends an alert if usage exceeds a threshold.

#!/bin/bash

THRESHOLD=80
EMAIL="admin@example.com"

df -h | awk 'NR>1{print $5 " " $6}' | while read output; do
  usage=$(echo $output | awk '{print $1}' | sed 's/%//')
  partition=$(echo $output | awk '{print $2}')
  
  if [ $usage -ge $THRESHOLD ]; then
    echo "Warning: Disk usage on $partition has reached $usage%" | mail -s "Disk Space Alert" $EMAIL
  fi
done

