#!/bin/bash

# Get the absolute path of the start script
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
START_SCRIPT="$PROJECT_DIR/start.sh"

echo "Setting up 'sidecar' alias..."

# Detect shell config file
if [ -f "$HOME/.zshrc" ]; then
    CONFIG_FILE="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then
    CONFIG_FILE="$HOME/.bashrc"
else
    echo "Could not find .bashrc or .zshrc. Please add the alias manually:"
    echo "alias sidecar='$START_SCRIPT'"
    exit 1
fi

# Check if alias already exists
if grep -q "alias sidecar=" "$CONFIG_FILE"; then
    echo "Alias 'sidecar' already exists in $CONFIG_FILE. Updating path..."
    sed -i "s|alias sidecar=.*|alias sidecar='$START_SCRIPT'|" "$CONFIG_FILE"
else
    echo "" >> "$CONFIG_FILE"
    echo "# Terminal Side-car Alias" >> "$CONFIG_FILE"
    echo "alias sidecar='$START_SCRIPT'" >> "$CONFIG_FILE"
    echo "Added 'sidecar' alias to $CONFIG_FILE"
fi

echo "Done! Restart your terminal or run: source $CONFIG_FILE"
echo "You can now launch the app by simply typing: sidecar"
