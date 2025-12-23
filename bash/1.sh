#!/bin/bash

[ $# -ne 2 ] && exit 1
filename="$1"
duration="$2"
[[ "$duration" =~ ^[0-9]+$ ]] && [ "$duration" -gt 0 ] || exit 1

> "$filename"
end_time=$(( $(date +%s) + duration ))

while [ $(date +%s) -lt $end_time ]; do
    echo "$(date +'%d.%m.%y %H:%M') = $(cat /proc/loadavg)" >> "$filename"
    sleep 1
done
