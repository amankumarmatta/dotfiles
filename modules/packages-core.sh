#!/bin/bash

install_core_packages() {
    local packages=(
        ntfs-3g mesa gnome-keyring noto-fonts-cjk noto-fonts noto-fonts-extra
        noto-fonts-emoji libsecret seahorse efibootmgr os-prober lib32-mesa
        vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader
        bluez bluez-utils
    )

    local to_install=()
    for pkg in "${packages[@]}"; do
        if pacman -Qi "$pkg" >/dev/null 2>&1; then
            info "$pkg already installed — skipping."
        else
            to_install+=("$pkg")
        fi
    done

    if (( ${#to_install[@]} > 0 )); then
        yay -S --noconfirm "${to_install[@]}"
    fi
}
