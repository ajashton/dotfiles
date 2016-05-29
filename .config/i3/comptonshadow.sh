#!/usr/bin/env bash

# This script provides an option for distinguishing floating windows from
# tiled windows so we can configure compton to apply shadows to the former
# but not the latter. It works by manually setting/unsetting a custom window
# property whenever floating status is toggled in i3.

# ~/.config/i3/config example:
# bindsym Mod4+Shift+space exec --no-startup-id ~/.config/i3/comptonshadow.sh, floating toggle

# ~/.config/compton.conf example:
# shadow-exclude = [
#    "! _COMPTON_SHADOW@:32c = 1 && ! name ^= '[i3 con] floatingcon around'"
# }

main() {
    local active
    local status
    active="$(xprop -notype -root _NET_ACTIVE_WINDOW)"
    status="$(xprop -notype -id "${active##*\ }" _COMPTON_SHADOW)"
    if [ "$status" = "_COMPTON_SHADOW = 1" ]; then
        xprop -id "${active##*\ }" -remove _COMPTON_SHADOW
    else
        xprop -id "${active##*\ }" -f _COMPTON_SHADOW 32c -set _COMPTON_SHADOW 1
    fi
}

main

exit 0
