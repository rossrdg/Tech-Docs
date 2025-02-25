# Change a User’s Password / Allows changing a user's password interactively.
#!/bin/bash

read -p "Enter username: " USERNAME
passwd "$USERNAME"
