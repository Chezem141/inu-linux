#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Error: Directory path required" >&2
    exit 1
fi

path="$1"

if [ ! -d "$path" ]; then
    echo "Error: Directory '$path' does not exist" >&2
    exit 1
fi

for dir in "$path"/*/; do
    if [ -d "$dir" ]; then
        dir_name=$(basename "$dir")
        count=$(find "$dir" -maxdepth 1 -type f 2>/dev/null | wc -l)
        echo "$count" > "${dir_name}.txt"
    fi
done
