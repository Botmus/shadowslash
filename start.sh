#!/bin/bash

# Detect Platform
OS="$(uname)"
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ "$OS" == "Darwin" ]; then
  CHROME_BIN="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
  CHROME_FLAGS="--app=http://localhost:3000 --window-size=400,800"
else
  # Linux (assuming standard install or the playwright path we found)
  if [ -f "/home/archrasmus/.cache/ms-playwright/chromium-1223/chrome-linux64/chrome" ]; then
    CHROME_BIN="/home/archrasmus/.cache/ms-playwright/chromium-1223/chrome-linux64/chrome"
  else
    CHROME_BIN="google-chrome"
  fi
  CHROME_FLAGS="--app=http://localhost:3000 --window-size=400,800 --ozone-platform=wayland --disable-vulkan"
fi

cd "$PROJECT_DIR"

# Ensure dependencies are installed
if [ ! -d "node_modules" ]; then
  echo "Installing dependencies..."
  npm install --silent
fi

# Start Node.js server in the background
node server.js &
SERVER_PID=$!

# Wait for server to start
echo "Waiting for server to start..."
until curl -s http://localhost:3000 > /dev/null; do
  sleep 0.5
done

echo "Launching Terminal Side-car on $OS..."
# Launch Chrome in App Mode
"$CHROME_BIN" $CHROME_FLAGS

# Kill server when chrome is closed
kill $SERVER_PID 2>/dev/null
echo "Side-car closed."
