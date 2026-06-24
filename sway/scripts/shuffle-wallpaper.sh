#!/usr/bin/env sh

set -eu

reload=1
if [ "${1:-}" = "--no-reload" ]; then
    reload=0
fi

wallpaper_dir="$HOME/.config/wallpapers"

wallpaper=$(
    find "$wallpaper_dir" -maxdepth 1 -type f \
        \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' \) \
        | shuf -n 1
)

[ -n "$wallpaper" ] || exit 0

if [ "$reload" -eq 1 ]; then
    exec "$HOME/.config/sway/scripts/apply-wallpaper-theme.sh" "$wallpaper"
else
    exec "$HOME/.config/sway/scripts/apply-wallpaper-theme.sh" --no-reload "$wallpaper"
fi
