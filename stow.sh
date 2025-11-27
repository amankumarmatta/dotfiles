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

core_packages=(
    "gnome-keyring"
    "libsecret"
    "seahorse"
    "efibootmgr"
    "os-prober"
    "lib32-mesa" "vulkan-radeon" "lib32-vulkan-radeon" "vulkan-icd-loader" "lib32-vulkan-icd-loader"
)

install_packages "${core_packages[@]}"

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
    "sddm-silent-theme"
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
    "linux-wallpaperengine-git"
)

if command_exists yay; then
    echo "📦 Installing AUR packages..."
    yay -S --noconfirm "${aur_packages[@]}"
else
    echo "⚠️ yay not available, skipping AUR packages"
fi

echo "✅ Package installation completed!"

# -----------------------------
# STOW SECTION (UPDATED)
# -----------------------------
echo "📁 Restoring dotfiles..."

cd "$HOME/.config" || exit
mkdir -p hypr fastfetch fish kitty rofi waybar
cd "$HOME/dotfiles" || exit

echo "📦 Stowing fastfetch..."
stow --target=$HOME/.config/fastfetch fastfetch

echo "📦 Stowing fish..."
stow --target=$HOME/.config/fish fish

echo "📦 Stowing hypr..."
stow --target=$HOME/.config/hypr hypr

echo "📦 Stowing kitty..."
stow --target=$HOME/.config/kitty kitty

echo "📦 Stowing rofi..."
stow --target=$HOME/.config/rofi rofi

echo "📦 Stowing waybar..."
stow --target=$HOME/.config/waybar waybar

echo "📦 Stowing swaync..."
stow --target=$HOME/.config/swaync swaync

echo "📦 Stowing nvim..."
stow --target=$HOME/.config/nvim nvim

echo "📦 Stowing starship..."
stow --target=$HOME/.config starship

echo "📦 Stowing wallust..."
stow --target=$HOME/.config wallust

echo "📦 Stowing qt5ct..."
stow --target=$HOME/.config qt5ct

echo "📦 Stowing qt6ct..."
stow --target=$HOME/.config qt6ct

echo "📦 Stowing wlogout..."
stow --target=$HOME/.config wlogout

echo "📦 Stowing Wallpapers..."
stow --target=$HOME Wallpapers

echo "📦 Stowing cursors if present..."
stow --target=$HOME/.icons cursors 2>/dev/null || true

echo "📦 Stowing themes if present..."
stow --target=$HOME/.themes themes 2>/dev/null || true

echo "🎉 All dotfiles stowed successfully!"

#!/bin/bash

FSTAB_ENTRY="# /dev/sdb1
UUID=2D5D808922F7E507   /mnt/hdd   ntfs-3g   defaults,uid=1000,gid=1000,umask=022   0  0"

# Ensure mount directory exists
sudo mkdir -p /mnt/hdd

# Append ONLY if not already present
if ! grep -q "UUID=2D5D808922F7E507" /etc/fstab; then
    echo "Adding NTFS HDD entry to /etc/fstab..."
    echo -e "\n$FSTAB_ENTRY" | sudo tee -a /etc/fstab > /dev/null
else
    echo "Entry already exists in /etc/fstab — skipping."
fi

# Validate fstab
echo "Validating /etc/fstab..."
sudo mount -a && echo "fstab OK!"

echo "🔄 You may need to log out and back in for Hyprland to work properly."
