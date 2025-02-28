# Monitor Specific Directory. Check usage of a specific directory and send an alert.

#!/bin/bash

DIR="/home"
THRESHOLD=80

USAGE=$(df -h $DIR | awk 'NR==2 {print $5}' | sed 's/%//')

if [ $USAGE -ge $THRESHOLD ]; then
  echo "Warning: $DIR usage is at $USAGE%" | mail -s "Directory Space Alert" admin@example.com
fi


