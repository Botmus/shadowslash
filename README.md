# Terminal Side-car 🚀

A lightweight, context-aware command assistant that lives next to your terminal. It dynamically detects active terminal sessions and provides a searchable "slash command" cheat sheet for whatever app you are currently running.

![Cross-Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS-blue)
![License](https://img.shields.io/badge/License-MIT-green)

## ✨ Features

- **Context-Aware:** Automatically detects if you are in a standard shell, Gemini CLI, Hermes, etc.
- **Dynamic Session Switching:** Pick between multiple open terminals via a dropdown.
- **Fuzzy Search:** Quickly find the command you need.
- **App Mode:** Launches in a sleek, standalone window (powered by Chrome/Chromium).
- **Extensible:** Easily add custom command sets via JSON files.

## 🚀 Getting Started

### Prerequisites
- [Node.js](https://nodejs.org/) (v16 or newer)
- Google Chrome or Chromium

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/terminal-sidecar.git
   cd terminal-sidecar
   ```
2. Run the installation script to set up the `sidecar` command:
   ```bash
   ./install.sh
   ```
3. Restart your terminal or run `source ~/.bashrc` (or `~/.zshrc`).

### Usage
Simply type the following command in any terminal:
```bash
sidecar
```

## 🛠 Adding Custom Commands

To support a new application, create a JSON file in the `commands/` directory:

`commands/git.json`
```json
[
  { "command": "git status", "description": "Check the status of your changes." },
  { "command": "git pull", "description": "Fetch and integrate remote changes." }
]
```
The app will automatically load these commands when it detects a `git` process in the foreground.

## 📜 License
MIT
