# Bash script to check if a process is running and terminate it if found. The script will:
# ✅ Accept a process name or PID as an argument.
# ✅ Check if the process is running.
# ✅ If found, kill the process gracefully (SIGTERM), and if needed, forcefully (SIGKILL).
# ✅ Log actions to a file (/var/log/process_killer.log).

#!/bin/bash

# Log file
LOGFILE="/var/log/process_killer.log"

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOGFILE
}

# Check if the script is run with a process name or PID
if [[ -z "$1" ]]; then
    log_message "Usage: $0 <process_name_or_pid>"
    exit 1
fi

PROCESS=$1

# Check if the input is a PID (numeric) or a process name
if [[ "$PROCESS" =~ ^[0-9]+$ ]]; then
    PID=$PROCESS
else
    # Get the PID of the process by name
    PID=$(pgrep -f "$PROCESS")
fi

# Check if the process is running
if [[ -z "$PID" ]]; then
    log_message "Process '$PROCESS' not found. Nothing to kill."
    exit 0
fi

log_message "Found process '$PROCESS' with PID: $PID. Attempting to terminate..."

# Try to terminate the process gracefully
kill "$PID"
sleep 3  # Wait a few seconds

# Check if the process is still running
if ps -p "$PID" > /dev/null 2>&1; then
    log_message "Process '$PROCESS' did not terminate. Forcing kill..."
    kill -9 "$PID"
    log_message "Process '$PROCESS' (PID: $PID) has been forcefully terminated."
else
    log_message "Process '$PROCESS' (PID: $PID) terminated successfully."
fi

exit 0

#What This Script Does:
#✅ Finds the process by name or PID (pgrep -f <process>).
#✅ Attempts graceful termination (kill <PID>).
#✅ Waits and checks if the process is still running.
#✅ Forces termination if needed (kill -9 <PID>).
#✅ Logs all actions to /var/log/process_killer.log.

#This ensures the process is properly terminated while avoiding unnecessary force kills.