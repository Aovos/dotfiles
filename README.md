# ❄️ My Personal Dotfiles (Linux)

> A declarative, keyboard-driven Linux environment built around NixOS and Hyprland.

Welcome to my personal Linux setup, focused on reproducibility, workflow automation, and a clean modern desktop experience.

The core of this environment is powered by **NixOS** and the **Hyprland** dynamic tiling compositor, supported by a carefully customized collection of tools, scripts, and automations that I use in my daily workflow.

## 📋 Table of Contents

- [🛠 Philosophy](#-philosophy)
- [🎬 Workflow Showcase](#-workflow-showcase)
- [⚡ Components & Features](#-components--features)
- [🚀 Installation & Setup](#-installation--setup)

## 🛠 Philosophy

This repository is both my daily workstation configuration and a long-term learning project.

The setup follows a simple principle: keep the system understandable, maintainable, and focused.

Inspired by the KISS (Keep It Simple, Stupid) philosophy, I appreciate the transparency and user control of Arch Linux while also valuing the stability-first approach commonly associated with Debian.

NixOS allows me to combine many of the strengths of both worlds: modern software, declarative configuration, reproducible environments, versioned system generations, and safe rollbacks.

Another core principle behind this setup is focus. Rather than spreading applications and information across multiple monitors, I prefer a workspace-driven workflow that keeps attention centered on the current task.

> The objective is not to see more. The objective is to focus better.

Areas I am currently exploring:

- Declarative system management with NixOS
- Linux desktop customization
- Wayland ecosystem tooling
- Lua-based application configuration
- Workflow automation through scripting
- Reproducible and maintainable system design

## 🎬 Workflow Showcase

![Monitor](assets/screenshot-monitor.png)
![Neovim](assets/screenshot-neovim.png)
![Multi-Apps](assets/screenshot_multi_applications.png)

## ⚡ Components & Features

- **KISS Philosophy & Declarative Management**
  Inspired by Arch Linux’s simplicity and Debian’s stability. Powered by NixOS, the entire system is managed declaratively, creating a maintainable and reproducible environment with safe upgrades, atomic rollbacks, and versioned system generations.

- **Modular & Reusable Architecture**
  Configurations are organized into self-contained modules that can be maintained, replaced, or extended independently. This keeps the system scalable, easy to understand, and simple to evolve over time.

- **Focus-First Workflow**
  Designed around a single-monitor workspace philosophy. Rather than spreading information across multiple screens, tasks are intentionally brought into focus through dedicated virtual workspaces. The objective is not to see more, but to focus better.

- **Workspace-Driven Organization**
  Applications automatically launch in predefined workspaces based on their purpose, such as development, communication, administration, or media. This keeps contexts separated and prevents new windows from disrupting the current workflow.

- **Dynamic Window Management**
  Windows can be shown, hidden, pinned, moved, tiled, floated, or configured through keyboard shortcuts. Frequently used tools can follow across workspaces, while less relevant content stays out of sight until needed.

- **Automation-First Approach**
  Repetitive tasks are automated wherever possible. Applications, services, scripts, and workflows can be triggered automatically at startup or through custom keybindings, reducing friction and unnecessary manual interaction.

- **Consistent Cross-Device Experience**
  The same workspace structure, shortcuts, workflows, and configuration principles are available across both desktop and laptop environments, allowing seamless transitions between devices.

- **Intentional Visual Design**
  Every visual decision serves usability and focus:
  - **Dark-Mode First** – A calm foundation that reduces visual noise and remains comfortable during long sessions.
  - **Purposeful Accent Colors** – Colors are used only where emphasis, status, or attention is required.
  - **Minimal Interface Chrome** – Unnecessary title bars and window decorations are removed to maximize usable screen space.
  - **Rounded Corners** – Softer shapes create a calmer and more modern visual appearance.
  - **Transparency & Layering** – Visual depth helps preserve context without overwhelming the active workspace.

- **Personalized Development Environment**
  Built around a heavily customized Neovim configuration instead of large monolithic IDEs. Every component is intentionally selected to create a lightweight, efficient, highly customizable, and distraction-free development experience.

- **Custom Desktop Ecosystem**
  Hyprland, Quickshell, Waybar, Rofi, Dunst, Alacritty, and supporting scripts work together as a cohesive keyboard-driven environment focused on productivity, consistency, and flexibility.

- **Gaming & Performance**
  Steam, Gamemode, and performance-related optimizations are integrated directly into the system configuration and managed alongside the rest of the operating system.

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
