#!/bin/bash

run_stow() {
    local CONFIG_DIR="$HOME/.config"
    mkdir -p "$CONFIG_DIR"

    local folders=(hypr waybar kitty fastfetch rofi wlogout)

    for folder in "${folders[@]}"; do
        if [[ -d "$HOME/dotfiles/$folder" ]]; then
            if [[ -e "$CONFIG_DIR/$folder" ]]; then
                info "$folder already exists in .config — skipping."
            else
                info "Stowing $folder..."
                stow --target="$CONFIG_DIR" "$folder"
                ok "Stowed $folder."
            fi
        else
            warn "Folder $folder missing in dotfiles — skipping."
        fi
    done
}
