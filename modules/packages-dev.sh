#!/bin/bash

install_dev_packages() {
    local packages=(
        python python-pip go rustup jdk-openjdk dotnet-sdk nodejs npm
        gcc clang cmake make ninja gdb lldb valgrind perf docker docker-compose
        virtualbox wireshark-qt postman-bin insomnia sqlitebrowser git-lfs github-cli
        mono
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
