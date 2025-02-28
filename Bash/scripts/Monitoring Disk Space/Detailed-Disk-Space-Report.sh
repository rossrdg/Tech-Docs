# Detailed Disk Space Report. This script provides a more detailed disk space report.

#!/bin/bash

echo "Disk Usage Report"
echo "-----------------"
df -hT | awk '{print $1, $2, $3, $4, $5, $6}'

