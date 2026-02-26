#!/bin/bash

# Navigate to the container directory
cd /home/container || exit 1

# Make internal Docker IP available to processes
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Replace environment variables in the startup command
# This takes the "Startup Command" from the Pterodactyl UI and executes it
MODIFIED_STARTUP=$(echo -e "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/\}/g')

echo -e "\033[1;33m--- Starting Pterodactyl Server ---\033[0m"
echo -e "\033[1;33mWorking Directory: /home/container\033[0m"

# Run the modified startup command
eval "${MODIFIED_STARTUP}"