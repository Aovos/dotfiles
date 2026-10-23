# ❄️ My Personal Dotfiles (Linux)

> A declarative, keyboard-driven Linux environment built around NixOS and Hyprland.

Welcome to my personal Linux setup, focused on reproducibility, workflow automation, and a clean modern desktop experience.

The core of this environment is powered by **NixOS** and the **Hyprland** dynamic tiling compositor, supported by a carefully customized collection of tools and scripts that I use in my daily workflow.

## 📋 Table of Contents

- [🛠 Philosophy](#-philosophy)
- [🎬 Workflow Showcase](#🎬-workflow-showcase)
- [🎯 Core Tech Stack](#-core-tech-stack)
- [⚡ Key Features](#-key-features)
- [🚀 Installation & Setup](#-installation--setup)

## 🛠 Philosophy

This repository is both my daily workstation configuration and a long-term learning project.

Instead of relying on default settings, I prefer to understand how the individual components of a Linux desktop environment work together and build a setup that matches my workflow.

Areas I am currently exploring:

- Declarative system management with NixOS
- Linux desktop customization
- Wayland ecosystem tooling
- Lua-based application configuration
- Workflow automation through scripting
- Reproducible and maintainable system design

The goal is not only to create an efficient desktop environment, but also to gain a deeper understanding of the technologies behind it.

## 🎬 Workflow Showcase
![Monitor](assets/screenshot-monitor.png)
![Neovim](assets/screenshot-neovim.png)
![Multi-Apps](assets/screenshot_multi_applications.png)

## 🎯 Core Tech Stack

- **OS:** NixOS (declarative and reproducible system configuration)
- **WM:** Hyprland (Wayland-based dynamic tiling compositor)
- **Terminal:** Alacritty (GPU-accelerated terminal emulator)
- **Editor:** Neovim (Lua-based configuration)
- **Status Bar:** Waybar (custom modules and CSS styling)
- **Application Launcher:** Rofi (custom launchers and power menus)
- **Notifications:** Dunst (lightweight notification daemon)

---

## ⚡ Key Features

- **Declarative System Management** through NixOS
- **Automated Dotfile Deployment** using a custom symlink script
- **Multi-Monitor Hyprland Layouts** optimized for productivity
- **Custom Waybar Modules**, including:
  - Weather integration
  - Calendar preview
  - Workspace indicators
  - Backlight controls
  - System monitoring widgets
- **Custom Rofi Menus** and power controls
- **Gaming Support** with Steam and Gamemode integration
- **Lua-Based Neovim Configuration** tailored to development workflows
- **Personal Utility Scripts** for automation and desktop integration

---

## 🚀 Installation & Setup

> ⚠️ These dotfiles are tailored to my personal workflow and hardware. Review all configurations before applying them to your system.

### Clone the repository

```bash
git clone https://github.com/Aovos/dotfiles.git
cd dotfiles
```

### Deploy user configuration files

```bash
chmod +x symlinks.sh
./symlinks.sh
```

### Apply the NixOS configuration

```bash
sudo nixos-rebuild switch
```
