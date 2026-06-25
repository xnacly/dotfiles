#!/usr/bin/env sh

case "${1:-toggle}" in
  up)
    pamixer -i 5
    ;;
  down)
    pamixer -d 5
    ;;
  toggle)
    pamixer -t
    ;;
  *)
    printf 'usage: %s [up|down|toggle]\n' "$0" >&2
    exit 2
    ;;
esac

if [ "$(pamixer --get-mute)" = "true" ]; then
  notify-send -u low "Volume" "Muted"
else
  notify-send -u low "Volume" "$(pamixer --get-volume)%"
fi

pkill -RTMIN+10 i3blocks 2>/dev/null || true
