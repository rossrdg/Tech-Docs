# Bash script to disable user accounts on a Linux system. The script will:
# ✅ Disable a specified user account by locking the password.
# ✅ Expire the account to prevent logins.
# ✅ Optionally move the user’s home directory to a backup location.
# ✅ Log all actions to a file.

#!/bin/bash

# Log file
LOGFILE="/var/log/disable_user.log"

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOGFILE
}

# Check if the script is run as root
if [[ $EUID -ne 0 ]]; then
    log_message "This script must be run as root!"
    exit 1
fi

# Check if a username was provided
if [[ -z "$1" ]]; then
    log_message "Usage: $0 <username>"
    exit 1
fi

USERNAME=$1

# Check if the user exists
if ! id "$USERNAME" &>/dev/null; then
    log_message "User '$USERNAME' does not exist."
    exit 1
fi

log_message "Disabling user account: $USERNAME"

# Lock the user account
usermod -L "$USERNAME"
log_message "User '$USERNAME' has been locked."

# Expire the user account
chage -E 0 "$USERNAME"
log_message "User '$USERNAME' has been expired."

# Move the user's home directory (optional)
HOMEDIR=$(eval echo "~$USERNAME")
BACKUP_DIR="/home/disabled_users"
mkdir -p "$BACKUP_DIR"

if [[ -d "$HOMEDIR" ]]; then
    mv "$HOMEDIR" "$BACKUP_DIR/${USERNAME}_backup_$(date +%Y%m%d%H%M%S)"
    log_message "Moved home directory of '$USERNAME' to '$BACKUP_DIR'."
fi

# Kill any running processes of the user
pkill -u "$USERNAME"
log_message "Killed any running processes of '$USERNAME'."

log_message "User '$USERNAME' has been successfully disabled."

exit 0

# What This Script Does:
# ✅ Locks the user account (usermod -L)
# ✅ Expires the account (chage -E 0)
# ✅ Moves home directory to /home/disabled_users/ (for backup)
# ✅ Kills active user processes (pkill -u username)
# ✅ Logs all actions to /var/log/disable_user.log

# This ensures the user cannot log in or use the system while keeping their files for recovery if needed.