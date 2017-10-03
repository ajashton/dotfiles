#!/usr/bin/env bash
set -eu -o pipefail

emojidb="$HOME/.local/share/emojis.db"

if [[ ! -e "$emojidb" ]]; then
    sqlite "$emojidb" <<< "create table emojis (emoji text, name text, keywords text, use_count integer);"
    # TODO: bootstrap db contents
fi

selection="$(sqlite3 "$emojidb" $'select emoji||\'\t\'||name from emojis order by use_count desc, emoji;' \
    | rofi -dmenu -i -p "☺ " -mesg '<span font_size="x-small" color="#888">Emoji Search</span>' \
    | awk '{print $1}')"

echo -n "$selection" | xclip -selection clipboard

notify-send "$selection" -i edit-copy

sqlite3 "$emojidb" "update emojis set use_count = use_count + 1 where emoji = '$selection';"
