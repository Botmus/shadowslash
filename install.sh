#!/bin/bash

# Get the absolute path of the start script
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
START_SCRIPT="$PROJECT_DIR/start.sh"

echo "Setting up 'shadowslash' alias..."

# Detect shell config file
if [ -f "$HOME/.zshrc" ]; then
    CONFIG_FILE="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then
    CONFIG_FILE="$HOME/.bashrc"
else
    echo "Could not find .bashrc or .zshrc. Please add the alias manually:"
    echo "alias shadowslash='$START_SCRIPT'"
    exit 1
fi

# Check if alias already exists
if grep -q "alias shadowslash=" "$CONFIG_FILE"; then
    echo "Alias 'shadowslash' already exists in $CONFIG_FILE. Updating path..."
    sed -i "s|alias shadowslash=.*|alias shadowslash='$START_SCRIPT'|" "$CONFIG_FILE"
else
    echo "" >> "$CONFIG_FILE"
    echo "# ShadowSlash Alias" >> "$CONFIG_FILE"
    echo "alias shadowslash='$START_SCRIPT'" >> "$CONFIG_FILE"
    echo "Added 'shadowslash' alias to $CONFIG_FILE"
fi

echo "Done! Restart your terminal or run: source $CONFIG_FILE"
echo "You can now launch the app by simply typing: shadowslash"
