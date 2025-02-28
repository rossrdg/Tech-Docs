# Ping server per subnet

#!/bin/bash
for((i=0;i<256;i++)); do
    ping -c 1 23.227.36.$i >> /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "Server 23.227.36.$i is up and running."
    else
        echo "Server 23.227.36.$i is unreachable."
    fi
done