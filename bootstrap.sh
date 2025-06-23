# ~/dotfiles/bootstrap.sh

#!/bin/bash
set -e

echo "Restoring dotfiles..."

cd ~/dotfiles

apps=(hypr rofi kitty waybar fastfetch zsh wlogout cava)

for app in "${apps[@]}"; do
  echo "Stowing $app..."
  stow "$app"
done

echo "✅ All dotfiles stowed successfully."