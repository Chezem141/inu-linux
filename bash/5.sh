#!/bin/bash

> logs.log
for log_file in /var/log/*.log; do
    if [ -f "$log_file" ] && [ -r "$log_file" ]; then
        last_line=$(tail -n 1 "$log_file" 2>/dev/null)
        if [ -n "$last_line" ]; then
            echo "$last_line" >> logs.log
        fi
    fi
done
