#!/usr/bin/env bash
cover="$(playerctl metadata mpris:artUrl)"

notify-send -u low -t 2000 -a ncmpcpp -r 27072 "$(playerctl metadata --all-players --format '{{title}}')" "<span color='#fdf6e3'>$(playerctl metadata --all-players --format '{{artist}}')</span>\n<span color='#268bd2'>$(playerctl metadata --all-players --format '{{album}}')</span>" -i "${cover}"
