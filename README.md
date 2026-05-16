# ShadowSlash 🚀

A lightweight, context-aware command assistant that lives next to your terminal. It dynamically detects active terminal sessions and provides a searchable "slash command" cheat sheet for whatever app you are currently running.

![Cross-Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS-blue)
![License](https://img.shields.io/badge/License-MIT-green)

## ✨ Features

- **Context-Aware:** Automatically detects if you are in a standard shell, Gemini CLI, Hermes, etc.
- **Shadow Detection:** Identifies specific tools even when they are nested inside node/python processes.
- **Dynamic Session Switching:** Pick between multiple open terminals via a glassmorphism dropdown.
- **Fuzzy Search:** Quickly find the exact command you need.
- **Most Wanted:** Automatically tracks your usage and moves your favorite commands to the top.
- **App Mode:** Launches in a sleek, standalone window.
- **Extensible:** Add custom command sets by simply dropping a JSON file in `commands/`.

## 🚀 Getting Started

### Prerequisites
- [Node.js](https://nodejs.org/) (v16 or newer)
- Google Chrome or Chromium

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/shadowslash.git
   cd shadowslash
   ```
2. Run the installation script to set up the `shadowslash` command:
   ```bash
   ./install.sh
   ```
3. Restart your terminal or run `source ~/.zshrc` (or `.bashrc`).

### Usage
Simply type the following command in any terminal:
```bash
shadowslash
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

## 🚀 Future Roadmap

ShadowSlash is just getting started. Here is the planned order of features:

1.  **Auto-Inject:** Automatically send clicked commands directly into the active terminal session (no more manual paste).
2.  **Global Hotkey:** Summon or hide ShadowSlash from anywhere with a custom keyboard shortcut (e.g., `Ctrl+Space`).
3.  **Deep Explanation:** Real-time breakdown of command flags (e.g., explaining what `-rf` actually means) to help you learn as you go.
4.  **Dynamic Discovery:** Automatically scan active tools in the background to find new commands and update your cheat sheets.
5.  **Themes & Customization:** Personalize the look with different color schemes, transparency levels, and glassmorphism styles.

## 📜 License
MIT
