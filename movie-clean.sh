#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <number_of_days>"
    exit 1
fi

if [ "$1" == "list" ]; then
    if [ -z "$2" ]; then
        echo "Usage: $0 list <number_of_days>"
        exit 1
    fi
    find . -type d -mtime +"$2" | nl
    exit 0
fi

exclude_list=()
for arg in "${@:2}"; do
    exclude_list+=($(find . -type d -mtime +$1 | sed -n "${arg}p"))
done

find . -type d -mtime +$1 | while read -r dir; do
    if [[ ! " ${exclude_list[@]} " =~ " ${dir} " ]]; then
        rm -rf "$dir"
    fi
done