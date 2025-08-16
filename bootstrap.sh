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
    "nvidia"
    "unityhub"
    "kitty"
    "swww"
    "hyprlock"
    "swaync"
    "waybar"
    "rofi-wayland"
    "fastfetch"
    "fish"
    "wallust"
    "mpvpaper"
    "stow"
    "bc"
    "jq"
    "ffmpeg"
    "imagemagick"
    "yad"
    "notify-send"
    "nautilus"
    "cursor-bin"
    "steam"
    "neovim"
    "openrgb"
    "fzf"
    "lazygit"
    "sddm"
    "sddm-silent-theme "
    "zoxide"
    "visual-studio-code-bin"
    "ttf-jetbrains-mono-nerd"
    "ttf-ibm-plex"
    "ttf-roboto"
    "noto-fonts"
    "mangohud"
    "ttf-gohu-nerd"
    "pokemon-colorscripts-git"
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
