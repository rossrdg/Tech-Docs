# Add a User to a Group. Adds a user to an existing group.
#!/bin/bash

read -p "Enter username: " USERNAME
read -p "Enter group: " GROUP

usermod -aG "$GROUP" "$USERNAME"
echo "User $USERNAME added to group $GROUP."




