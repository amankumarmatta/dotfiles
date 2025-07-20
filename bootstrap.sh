# ~/dotfiles/bootstrap.sh

#!/bin/bash
set -e

echo "🚀 Starting dotfiles bootstrap..."

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   echo "❌ This script should not be run as root"
   exit 1
fi

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install packages
install_packages() {
    local packages=("$@")
    echo "📦 Installing packages: ${packages[*]}"
    
    # Check if yay is available, otherwise use pacman
    if command_exists yay; then
        yay -S --noconfirm "${packages[@]}"
    else
        echo "⚠️  yay not found, using pacman (some packages might not be available)"
        sudo pacman -S --noconfirm "${packages[@]}"
    fi
}

# Install required packages
echo "📦 Installing required packages..."

# Core packages available in official repos
core_packages=(
    "hyprland"
    "kitty"
    "swww"
    "hyprpaper"
    "swaync"
    "waybar"
    "rofi-wayland"
    "fastfetch"
    "zsh"
    "wallust"
    "mpvpaper"
    "stow"
    "bc"
    "jq"
    "ffmpeg"
    "imagemagick"
    "yad"
    "notify-send"
)

# Install core packages
install_packages "${core_packages[@]}"

# Install additional packages that might be in AUR
aur_packages=(
    "mpvpaper"
)

# Try to install AUR packages if yay is available
if command_exists yay; then
    echo "📦 Installing AUR packages..."
    yay -S --noconfirm "${aur_packages[@]}"
else
    echo "⚠️  yay not available, skipping AUR packages"
    echo "   You may need to install mpvpaper manually from AUR"
fi

echo "✅ Package installation completed!"

# Stow dotfiles
echo "📁 Restoring dotfiles..."

cd ~/dotfiles

apps=(hypr rofi kitty waybar fastfetch zsh wlogout cava Wallpapers wallust)

for app in "${apps[@]}"; do
  echo "📦 Stowing $app..."
  stow "$app"
done

echo "✅ All dotfiles stowed successfully."
echo "🎉 Bootstrap completed! You may need to log out and back in for Hyprland to work properly."