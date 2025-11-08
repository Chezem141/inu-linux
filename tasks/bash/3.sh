#!/bin/bash

for file in "$@"; do
    if [ -f "$file" ]; then
        lines=$(wc -l < "$file")
        echo "$file => $lines"
    else
        echo "$file => not found"
        exit 1
    fi
done
