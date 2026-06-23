#!/usr/bin/env sh
set -eu

config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/sway"
host="$(cat /etc/hostname)"
host_config="$config_dir/kanshi.$host.conf"
fallback_config="$config_dir/kanshi.conf"

pkill -x kanshi 2>/dev/null || true

if [ -f "$host_config" ]; then
    exec kanshi -c "$host_config"
fi

exec kanshi -c "$fallback_config"
