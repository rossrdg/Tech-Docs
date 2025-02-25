# Automated User Report Script
# This script generates a report containing: Username, UID, Home Directory, Last Login, Account Expiry Status
#!/bin/bash

REPORT_FILE="user_report_$(date +%F).txt"

echo "Generating User Report..."
echo "------------------------------------" > "$REPORT_FILE"
echo "Username | UID | Home Directory | Last Login | Expiry" >> "$REPORT_FILE"
echo "------------------------------------" >> "$REPORT_FILE"

while IFS=':' read -r username password uid gid info home shell; do
    if [[ $uid -ge 1000 ]]; then
        last_login=$(lastlog -u "$username" | awk 'NR==2 {print $4, $5, $6}')
        expiry=$(chage -l "$username" | grep "Account expires" | awk -F: '{print $2}')
        echo "$username | $uid | $home | $last_login | $expiry" >> "$REPORT_FILE"
    fi
done < /etc/passwd

echo "User Report saved to $REPORT_FILE"

# The report will be saved as user_report_YYYY-MM-DD.txt.