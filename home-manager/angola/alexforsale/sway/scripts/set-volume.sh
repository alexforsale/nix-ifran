#!/usr/bin/env bash
# original script from https://wiki.archlinux.org/index.php/Dunst
# <alexforsale@yahoo.com>
# changeVolume

pamixer="$(command -v pamixer)"
notify="$(command -v notify-send)"

# args = -i % or -d %
"${pamixer}" "${@}" > /dev/null
volume="$(${pamixer} --get-volume)"
mute="$(${pamixer} --get-mute)"
if [ "${mute}" == "true" ]; then
    icon="audio-volume-muted"
    symbol=""
elif [ "${mute}" == "false" ] &&
         [ "${volume}" -gt 0 ] &&
         [ "${volume}" -le 25 ]; then
    icon="audio-volume-low"
    symbol=""
elif [ "${mute}" == "false" ] &&
         [ "${volume}" -gt 25 ] &&
         [ "${volume}" -le 75 ]; then
    icon="audio-volume-medium"
    symbol=""
elif [ "${mute}" == "false" ] &&
         [ "${volume}" -gt 75 ]; then
    icon="audio-volume-high"
    symbol=""
fi

if [[ $volume == 0 || "$mute" == "true" ]]; then
    "${notify}" -a "changeVolume" -u low -t 1000 -i "${icon}" -h string:x-canonical-private-synchronous:volume "${symbol} Volume muted"
else
    "${notify}" -a "changeVolume" -u low -t 1000 -i "${icon}" -h string:x-canonical-private-synchronous:volume \
		-h int:value:"$volume" "${symbol} Volume: ${volume}%"
fi
