#!/bin/bash

update_fstab() {

    local UUID="2D5D808922F7E507"
    local ENTRY="UUID=$UUID   /mnt/Storage   ntfs-3g   defaults,uid=1000,gid=1000,umask=022   0  0"

    sudo mkdir -p /mnt/Storage

    if ! grep -q "^UUID=$UUID" /etc/fstab; then
        info "Adding NTFS HDD entry to /etc/fstab..."
        echo -e "\n# /dev/sdb1\n$ENTRY" | sudo tee -a /etc/fstab >/dev/null
        ok "fstab entry added."
    else
        info "fstab entry already exists — skipping."w
    fi

    sudo systemctl daemon-reload
    sudo mount -a && ok "fstab validated."
}
