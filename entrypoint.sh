#!/bin/bash

TZ=${TZ:-UTC}
export TZ

INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

cd /home/container || exit 1

rm -f /tmp/.X99-lock

printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0mStarting Xvfb op :99...\n"
Xvfb :99 -screen 0 1280x1024x24 +extension GLX +render -noreset >> /home/container/xvfb.log 2>&1 &

sleep 2

export DISPLAY=:99

printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0mjava -version\n"
java -version

PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0m%s\n" "$PARSED"
exec env ${PARSED}