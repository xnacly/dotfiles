#!/usr/bin/env sh

if [ "$BLOCK_BUTTON" = "1" ]; then
    ~/.config/sway/scripts/volume.sh toggle >/dev/null 2>&1
fi

if ! mute=$(pamixer --get-mute 2>/dev/null); then
    echo "vol n/a"
elif [ "$mute" = "true" ]; then
    echo "--%"
else
    volume=$(pamixer --get-volume 2>/dev/null) || volume=
    if [ -n "$volume" ]; then
        printf '%s%%\n' "$volume"
    else
        echo "vol n/a"
    fi
fi
