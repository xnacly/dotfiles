#!/usr/bin/env sh

set -eu

wallpaper_dir="$HOME/.config/wallpapers"

selection=$(
    find "$wallpaper_dir" -maxdepth 1 -type f \
        \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' \) \
        | sort \
        | while IFS= read -r wallpaper; do
            name=${wallpaper##*/}
            name=${name%.*}
            printf '%s\0icon\x1f%s\x1finfo\x1f%s\n' "$name" "$wallpaper" "$wallpaper"
        done \
        | rofi -dmenu \
            -theme "$HOME/.config/rofi/wallpaper-grid.rasi" \
            -p '$ ' \
            -show-icons \
            -format 'i'
)

[ -n "$selection" ] || exit 0

wallpaper=$(
    find "$wallpaper_dir" -maxdepth 1 -type f \
        \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' \) \
        | sort \
        | sed -n "$((selection + 1))p"
)

[ -n "$wallpaper" ] || exit 0

exec "$HOME/.config/sway/scripts/apply-wallpaper-theme.sh" "$wallpaper"
