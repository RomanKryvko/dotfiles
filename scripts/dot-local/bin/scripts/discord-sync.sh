#!/bin/bash
TEMP_DB="/tmp/temp-pacman-db-${UID}/"
DB_PATH="$(pacman-conf DBPath)"

mkdir -p $TEMP_DB

if [ ! -f "$TEMP_DB/local" ]; then
    ln -s "${DB_PATH}/local" "$TEMP_DB" &> /dev/null
fi

fakeroot -- pacman -Sy --dbpath "$TEMP_DB" --logfile /dev/null &> /dev/null;

mapfile -t version < <(pacman -Si discord | grep Version | awk '{ match($0, /[0-9]+\.[0-9]+\.[0-9]+/, a); print a[0] }')

sudo sed -i -E "s/[0-9]+\.[0-9]+\.[0-9]+/$version/" /opt/discord/resources/build_info.json
