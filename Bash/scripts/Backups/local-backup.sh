# Local Backup of directories

#!/bin/bash

# Create array with DIRs for backup
backup_dir=("/etc" "/boot")

# Set destination DIR for backup
dest_dir="/home/rosen/bkps"

# assign current date in format "month-day-year" to a variable
backup_date=$(date +%b-%d-%y)

# check if destination DIR exist - if not - create it
if [ ! -d $dest_dir ]; then
	mkdir $dest_dir
fi

echo "Starting Backup of : ${backup_dir[@]}"

# Loop all array elements in backup_dir
for i in ${backup_dir[@]}; do
	sudo tar -Pczf $dest_dir/$i-$backup_date.tar.gz $i
	if [ $? -eq 0 ]; then
		echo "$i backup successful"
	else
		echo "$i backup failed"
	fi
done
echo "Backup is done"
