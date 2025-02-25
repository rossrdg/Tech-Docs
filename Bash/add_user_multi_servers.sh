#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root!" >&2
    exit 1
fi

# Prompt for new username
read -p "Enter new username: " NEW_USER

# Prompt for default password (hidden input)
read -s -p "Enter default password: " PASSWORD
echo ""

# List of target servers (modify as needed)
SERVERS=(
    "server1.example.com"
    "server2.example.com"
    "server3.example.com"
)

# Optional: specify a group to add the user to
GROUP="devops"

for SERVER in "${SERVERS[@]}"; do
    echo "Adding user $NEW_USER to $SERVER..."
    
    ssh root@"$SERVER" bash <<EOF
        # Create the user if they do not exist
        id "$NEW_USER" &>/dev/null || useradd -m -s /bin/bash "$NEW_USER"

        # Set the user's password
        echo "$NEW_USER:$PASSWORD" | chpasswd

        # Add user to a specific group (optional)
        usermod -aG $GROUP "$NEW_USER"

        # Force password change on first login
        chage -d 0 "$NEW_USER"

        echo "User $NEW_USER added to $SERVER"
EOF
done

echo "User $NEW_USER added to all specified servers."
