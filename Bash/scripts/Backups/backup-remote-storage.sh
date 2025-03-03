# Local Backup of directories and transfer to destination server

#!/bin/bash

# Create array with DIRs for backup
backup_dir=("/etc" "/boot")

# Set destination DIR for backup
dest_dir="/home/rosen/bkps"

# sefine destination server
dest_server="bkpserver1.example.com"

# assign current date in format "month-day-year" to a variable
backup_date=$(date +%b-%d-%y)

echo "Starting Backup of : ${backup_dir[@]}"

# Loop all array elements in backup_dir
for i in ${backup_dir[@]}; do
	sudo tar -Pczf /tmp/$i-$backup_date.tar.gz $i
	if [ $? -eq 0 ]; then
		echo "$i backup successful"
	else
		echo "$i backup failed"
	fi

# Transfer  backup file to destination server	
	scp /tmp/$i-$backup_date.tar.gz $dest_server:$dest_dir
	if [ $? -eq 0 ]; then
		echo "$i backup transfer successful"
	else
		echo "$i backup transfer failed"
	fi
done

# Clean /tmp
sudo rm /tmp/*.gz
echo "Backup script is done"
