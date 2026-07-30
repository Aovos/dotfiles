{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # 🌐 Internet & Kommunikation
    firefox
    freetube
    chromium
    thunderbird
    signal-desktop
    teams-for-linux

    # 🧠 Produktivität & Wissen
    super-productivity
    marktext
    anki
    drawio

    # 🧾 Office & Dokumente
    libreoffice
    evince
    pdfmixtool
    pdfarranger
    xournalpp

    # 💻 Editoren & IDEs (Anwendungen)
    jetbrains.idea-oss
    jetbrains.rider
    helix
    micro

    # 🛠️ Terminal-Anwendungen & CLI-Tools
    git
    lazygit
    tmux
    fzf
    curl

    # 🖼️ Bild & Grafik
    inkscape
    gimp
    feh

    # 📸 Screenshots (Wayland-native)
    grim
    slurp
    satty

    # 🎵 Audio & Devices
    pavucontrol
    spotify
    songrec

    # 🎬 Video & Medien
    mpv
    obs-studio

    # 🎨 Themes & Styling
    gtk3
    gtk-layer-shell
    papirus-icon-theme
    (colloid-gtk-theme.override {
      tweaks = [ "black" ];
      colorVariants = [ "dark" ];
    })

    # 🧊 Window Manager Ecosystem (Hyprland Core Tools)
    hyprpaper
    hyprlock
    hypridle

    # 🖥️ User Interface (sichtbare Desktop-Tools)
    rofi
    dunst

    # 📁 Files & Storage (Dateien & Zugriff)
    nemo
    nautilus
    file-roller
    xdg-user-dirs

    # 📊 System Monitoring & Control
    mission-center
    btop
    brightnessctl
    playerctl

    # 🎨 Appearance & Theming
    dconf-editor
    font-manager

    # 🔌 Integration & Desktop Backend (unsichtbar, aber wichtig)
    glib
    dconf
    gsettings-desktop-schemas
    desktop-file-utils
    wl-clipboard

    # 🌐 Connectivity & Network Tools
    networkmanagerapplet
    rofi-network-manager
  ];
}
