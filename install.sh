#!/bin/sh
# Rex OS one-line installer
# Usage:
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/zen0x/rex-os/main/install.sh)"

set -e

REPO_URL="https://github.com/amankumarmatta/rexium.git"
INSTALL_DIR="$HOME/rexium"
BOOTSTRAP="$INSTALL_DIR/bootstrap.sh"

echo "🦖 Rex OS Installer"
echo "==================="

# --------------------------------------------------
# Safety checks
# --------------------------------------------------

if [ "$(id -u)" -eq 0 ]; then
  echo "❌ Do not run this installer as root."
  exit 1
fi

command -v curl >/dev/null 2>&1 || {
  echo "❌ curl is required but not installed."
  exit 1
}

command -v git >/dev/null 2>&1 || {
  echo "❌ git is required but not installed."
  exit 1
}

# --------------------------------------------------
# Clone or update repo
# --------------------------------------------------

if [ ! -d "$INSTALL_DIR/.git" ]; then
  echo "📥 Cloning Rex OS repository..."
  git clone --depth=1 "$REPO_URL" "$INSTALL_DIR"
else
  echo "🔄 Rex OS already installed — updating..."
  git -C "$INSTALL_DIR" pull --ff-only
fi

# --------------------------------------------------
# Verify bootstrap script
# --------------------------------------------------

if [ ! -x "$BOOTSTRAP" ]; then
  echo "🔧 Making bootstrap executable..."
  chmod +x "$BOOTSTRAP"
fi

# --------------------------------------------------
# Hand over control to the real installer
# --------------------------------------------------

echo
echo "🚀 Launching Rex OS bootstrap..."
echo

cd "$INSTALL_DIR"
exec "$BOOTSTRAP"
