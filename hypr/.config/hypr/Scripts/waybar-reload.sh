#!/bin/bash

# Simple script to reload waybar

echo "🔄 Reloading waybar..."

# Kill existing waybar process
if pgrep -x "waybar" >/dev/null; then
    echo "Killing existing waybar process..."
    pkill -x "waybar"
    sleep 1
fi

# Start new waybar process
echo "Starting new waybar process..."
waybar &

echo "✅ Waybar reloaded successfully!"