# Force Password Expiry for a User. Forces the user to change their password on next login.
#!/bin/bash

read -p "Enter username: " USERNAME
chage -d 0 "$USERNAME"
echo "User $USERNAME must change password on next login."


