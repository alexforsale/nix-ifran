#!/usr/bin/env bash
# original script from https://wiki.archlinux.org/index.php/Dunst
# <alexforsale@yahoo.com>
# changeBrightness

set -o errexit
set -o pipefail

# Arbitrary but unique message tag
brightnessctl="$(command -v brightnessctl)"
awk="$(command -v awk)"
notify="$(command -v notify-send)"

brightnessctl set "${@}" > /dev/null

max="$(${brightnessctl} max)"
current="$(${brightnessctl} get)"
percentage="$(${awk} -v current=${current} -v max=${max} 'BEGIN { print ( (current / max) * 100 )}')"
percentage="${percentage%.*}"

# Show the brightness notification
"${notify}" -a "changeBrightness" -u low -t 1000 -i audio-volume-high -h string:x-canonical-private-synchronous:brightness \
    -h int:value:"${percentage}" " Brightness: ${percentage}%"
