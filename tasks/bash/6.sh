#!/bin/bash

if [ "$FOO" = "5" ] && [ "$BAR" = "1" ]; then
    echo "Error: Execution not allowed" >&2
    exit 1
fi

# Метод с использованием временных меток
get_file_list() {
    find . -maxdepth 1 -type f -printf "%f " 2>/dev/null
}

initial_files=$(get_file_list)

# Краткий мониторинг с таймаутом
for i in {1..30}; do  # 30 итераций по 0.1 сек = 3 секунды максимум
    current_files=$(get_file_list)
    
    # Сравниваем списки
    for file in $current_files; do
        if ! echo " $initial_files " | grep -q " $file "; then
            echo "File appeared: $file"
            exit 0
        fi
    done
    
    sleep 0.1
done

exit 0
