#!/bin/bash

set -e
set -x

URL='https://www.archlinux.org/mirrorlist/?country=DE&protocol=https&ip_version=4&use_mirror_status=on'

MIRRORLIST="/etc/pacman.d/mirrorlist"

cp "$MIRRORLIST" "$MIRRORLIST.bak"

curl "$URL" \
    | grep -v '## Germany' \
    | sed 's/^#Server/Server/g' \
    | rankmirrors -n 20 - \
    > "$MIRRORLIST.new"

if [[ -s "$MIRRORLIST.new" ]]; then
    mv "$MIRRORLIST.new" "$MIRRORLIST"
fi

pacman -Syy --noconfirm
