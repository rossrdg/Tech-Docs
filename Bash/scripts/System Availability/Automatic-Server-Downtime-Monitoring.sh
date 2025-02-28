# Automatic Downtime Monitor

#!/bin/bash
servers=$(cat servers.txt)
for i in $servers; do
    ping -c 1 $i >> /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "Sending out an outage email."
        echo "$i is unreachable." | mail -s "$i Outage" your_email
    fi
done