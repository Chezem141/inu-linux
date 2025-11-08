#!/bin/bash

planet="$1"

declare -A moons=(
    ["Mercury"]=0
    ["Venus"]=0
    ["Earth"]=1
    ["Mars"]=2
    ["Jupiter"]=98
    ["Saturn"]=83
    ["Uranus"]=27
    ["Neptune"]=14
)

if [[ -n "${moons[$planet]}" ]]; then
    echo "${moons[$planet]}"
else
    echo "Unknown planet"
    exit 1
fi
