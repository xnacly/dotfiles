#!/usr/bin/env sh
set -eu

config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/sway"
host="$(cat /etc/hostname)"
host_config="$config_dir/kanshi.$host.conf"
fallback_config="$config_dir/kanshi.conf"

pkill -x kanshi 2>/dev/null || true

if [ -f "$host_config" ]; then
    selected_config="$host_config"
    selected_name="kanshi.$host.conf"
else
    selected_config="$fallback_config"
    selected_name="kanshi.conf"
fi

profiles="$(awk '/^[[:space:]]*profile[[:space:]]+/ { profiles = profiles (profiles ? ", " : "") $2 } END { print profiles }' "$selected_config")"
notify-send "kanshi" "Rechecking outputs with $selected_name${profiles:+: $profiles}" || true

exec kanshi -c "$selected_config"
