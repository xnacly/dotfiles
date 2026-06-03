#!/usr/bin/env bash

location=${WTTR_LOCATION:-}
url="https://wttr.in/${location}?format=%C%20%t"

output=$(timeout 3 curl -fsS "$url" 2>/dev/null) || {
  echo "weather n/a"
  exit 0
}

echo "${output,,}"
