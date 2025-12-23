#!/bin/bash

echo "$PATH" | tr ':' '\n' | while IFS= read -r dir; do
    if [ -n "$dir" ]; then
        if [ -d "$dir" ] && [ -r "$dir" ]; then
            count=$(find "$dir" -maxdepth 1 -type f -executable 2>/dev/null | wc -l)
            echo "$dir => $count"
        else
            :
        fi
    fi
done
