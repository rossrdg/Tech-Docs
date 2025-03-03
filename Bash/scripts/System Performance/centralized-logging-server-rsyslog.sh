# Bash script to set up a centralized logging server using rsyslog. The script will:
# - Install rsyslog (if not installed).
# - Configure the system as a central log server (listening on UDP 514 and TCP 514).
# - Restart the rsyslog service to apply changes.

#!/bin/bash

# Define log file for the script
LOGFILE="/var/log/rsyslog_setup.log"

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOGFILE
}

log_message "Starting rsyslog central log server setup..."

# Check if rsyslog is installed
if ! command -v rsyslogd &> /dev/null; then
    log_message "rsyslog is not installed. Installing now..."
    apt update && apt install -y rsyslog
    if [ $? -ne 0 ]; then
        log_message "Failed to install rsyslog. Exiting."
        exit 1
    fi
    log_message "rsyslog installed successfully."
else
    log_message "rsyslog is already installed."
fi

# Enable rsyslog to accept remote logs
log_message "Configuring rsyslog to receive logs..."

RSYSLOG_CONF="/etc/rsyslog.conf"

# Enable UDP and TCP reception in rsyslog.conf
sed -i '/^#module(load="imudp")/s/^#//' $RSYSLOG_CONF
sed -i '/^#input(type="imudp" port="514")/s/^#//' $RSYSLOG_CONF
sed -i '/^#module(load="imtcp")/s/^#//' $RSYSLOG_CONF
sed -i '/^#input(type="imtcp" port="514")/s/^#//' $RSYSLOG_CONF

log_message "rsyslog configured to accept UDP and TCP logs on port 514."

# Restart rsyslog service
log_message "Restarting rsyslog service..."
systemctl restart rsyslog

if systemctl is-active --quiet rsyslog; then
    log_message "rsyslog restarted successfully and is now running."
else
    log_message "Failed to restart rsyslog. Check logs for issues."
    exit 1
fi

# Allow traffic on port 514 for UDP and TCP
log_message "Configuring firewall to allow rsyslog traffic..."
ufw allow 514/udp
ufw allow 514/tcp
log_message "Firewall rules updated to allow rsyslog traffic."

log_message "Centralized rsyslog server setup complete."
