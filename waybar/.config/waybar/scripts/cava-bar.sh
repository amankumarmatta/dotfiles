#!/bin/bash

CAVA_FIFO="/tmp/cava.fifo"

# Kill any previous cava instance
pkill cava

# Create pipe if not exists
[[ -p "$CAVA_FIFO" ]] || mkfifo "$CAVA_FIFO"

# Characters for bars
BLOCKS=("▁" "▂" "▃" "▄" "▅" "▆" "▇" "█")

# Launch cava with the correct config
cava -p ~/.config/cava/config &

# Small delay to allow cava to start
sleep 1

# Read from FIFO and print visual bars
tail -f "$CAVA_FIFO" | while read -r line; do
    bar=""
    for val in $line; do
        idx=$(( val * 8 / 256 ))
        (( idx > 7 )) && idx=7
        bar+="${BLOCKS[$idx]}"
    done
    echo "$bar"
done
