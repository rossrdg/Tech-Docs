# Lock or Unlock a User Account. / Locks a user account to prevent login.
#!/bin/bash

read -p "Enter username to lock: " USERNAME
passwd -l "$USERNAME"
echo "User $USERNAME has been locked."

# To unlock the user:

passwd -u "$USERNAME"
echo "User $USERNAME has been unlocked."


