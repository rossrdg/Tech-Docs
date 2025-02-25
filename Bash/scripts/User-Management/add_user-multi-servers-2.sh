#This script creates a new user, sets a password, and forces a password change on first login.
#!/bin/bash

read -p "Enter new username: " NEW_USER
read -s -p "Enter password: " PASSWORD
echo ""

SERVERS=("server1" "server2" "server3")

for SERVER in "${SERVERS[@]}"; do
    ssh root@"$SERVER" bash <<EOF
        id "$NEW_USER" &>/dev/null || useradd -m -s /bin/bash "$NEW_USER"
        echo "$NEW_USER:$PASSWORD" | chpasswd
        chage -d 0 "$NEW_USER"
        echo "User $NEW_USER added to $SERVER"
EOF
done
