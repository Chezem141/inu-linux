#!/bin/bash

echo "Checking LC_* variables consistency..."

first_value=""
first_var=""
has_mismatch=0

for var in $(env | grep '^LC_' | cut -d= -f1); do
    value="${!var}"

    if [ -z "$first_value" ]; then
        first_value="$value"
        first_var="$var"
        echo "Reference: $var = $value"
    else
        if [ "$value" != "$first_value" ]; then
            echo "MISMATCH: $var = $value (expected: $first_value from $first_var)"
            has_mismatch=1
        else
            echo "Match: $var = $value"
        fi
    fi
done

if [ $has_mismatch -eq 1 ]; then
    echo "ERROR: Not all LC_* variables have the same value"
    exit 1
else
    echo "SUCCESS: All LC_* variables have the same value"
    exit 0
fi
