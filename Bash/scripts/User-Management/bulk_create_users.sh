# Bulk User Creation Script
# This script reads a file containing usernames and passwords, then creates users in the system.
# Create a file users.txt with the following format:

# username1,password1
# username2,password2

# Run the script to create users from the file. // sudo ./bulk_create_users.sh users.txt
#!/bin/bash

# Check if file is provided
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <user_list_file>"
    exit 1
fi

USER_FILE="$1"

# Check if the file exists
if [[ ! -f "$USER_FILE" ]]; then
    echo "File not found!"
    exit 1
fi

while IFS=',' read -r USERNAME PASSWORD; do
    # Create user if they do not exist
    if id "$USERNAME" &>/dev/null; then
        echo "User $USERNAME already exists. Skipping..."
    else
        useradd -m -s /bin/bash "$USERNAME"
        echo "$USERNAME:$PASSWORD" | chpasswd
        chage -d 0 "$USERNAME" # Force password change on first login
        echo "User $USERNAME created."
    fi
done < "$USER_FILE"

echo "Bulk user creation complete."




