#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

echo "--> Linking Desktop (Hyprland & Quickshell) configs..."
mkdir -p "$CONFIG_HOME"

if [ -d "$DIR/config/hypr" ]; then
    rm -rf "$CONFIG_HOME/hypr"
    ln -sf "$DIR/config/hypr" "$CONFIG_HOME/hypr"
    echo "    Linked hypr -> $CONFIG_HOME/hypr"
fi

if [ -d "$DIR/config/quickshell" ]; then
    rm -rf "$CONFIG_HOME/quickshell"
    ln -sf "$DIR/config/quickshell" "$CONFIG_HOME/quickshell"
    echo "    Linked quickshell -> $CONFIG_HOME/quickshell"
fi

# Clean legacy waybar symlink if present
if [ -L "$CONFIG_HOME/waybar" ]; then
    rm -f "$CONFIG_HOME/waybar"
    echo "    Cleaned legacy waybar link"
fi
