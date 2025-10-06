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
    "gnome-keyring"
    "libsecret"
    "seahorse"
    "efibootmgr"
    "os-prober"
)

# Install core packages
install_packages "${core_packages[@]}"

# Install additional packages that might be in AUR
aur_packages=(
    "mpvpaper"
    "hyprland"
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
    "thunar"
    "cursor-bin"
    "steam"
    "neovim"
    "openrgb"
    "fzf"
    "lazygit"
    "sddm"
    "starship"
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
    "zen-browser-bin"
    "linux-cachyos-bore"
    "linux-cachyos-bore-headers"
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

apps=(hypr kitty waybar nvim fastfetch swaync qt5ct qt6ct wlogout Wallpapers wallust starship fish)

for app in "${apps[@]}"; do
  echo "📦 Stowing $app..."
  stow "$app"
done

echo "✅ All dotfiles stowed successfully."
echo "🎉 Bootstrap completed! You may need to log out and back in for Hyprland to work properly."
