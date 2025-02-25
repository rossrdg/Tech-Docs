#Removes a user from multiple servers and deletes their home directory.
#!/bin/bash

read -p "Enter username to delete: " USERNAME

SERVERS=("server1" "server2" "server3")

for SERVER in "${SERVERS[@]}"; do
    ssh root@"$SERVER" bash <<EOF
        id "$USERNAME" &>/dev/null && userdel -r "$USERNAME" && echo "User $USERNAME removed from $SERVER"
EOF
done
