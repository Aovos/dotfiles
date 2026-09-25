{ config, pkgs, ... }:

{
  ####################################################################
  # Imports
  ####################################################################
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  ####################################################################
  # Systemversion & Update-Einstellungen
  ####################################################################
  system.stateVersion = "25.11";

  # Nix-Einstellungen (Platz sparen & Aufräumen)
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 20d";
  };

  nixpkgs.config.allowUnfree = true; # Proprietäre Software erlauben

  ####################################################################
  # Bootloader & Systemd
  ####################################################################
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Bootvorgang beschleunigen (wartet nicht auf Netzwerk)
  systemd.services.NetworkManager-wait-online.enable = false;

  ####################################################################
  # Netzwerk
  ####################################################################
  networking = {
    hostName = "sLaptop";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  ####################################################################
  # Zeit, Sprache & Konsolen-Layout
  ####################################################################
  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  console = {
    keyMap = "de";
    font = "Lat2-Terminus16";
  };

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  ####################################################################
  # Hardware & Services (Bluetooth, Audio, Drucker, SSD)
  ####################################################################
  hardware.enableAllFirmware = true;

  # Bluetooth mit experimentellen Funktionen aktivieren
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.Experimental = true;
  };
  services.blueman.enable = true;

  # Pipewire Audio-Setup mit Echtzeit-Priorität und 32-Bit Support
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  # Drucker-Unterstützung mit Avahi (IPv4 & IPv6 Support)
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
    openFirewall = true;
  };

  # Hardware-Dienste für Laptops (Akkuschonung & SSD-Pflege)
  services.fstrim.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Laptop-Deckelverhalten: Weiterlaufen lassen beim Zuklappen
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

  ####################################################################
  # Sicherheit & Rechteverwaltung
  ####################################################################
  security = {
    sudo.enable = true;
    polkit.enable = true;
    rtkit.enable = true;
  };

  ####################################################################
  # Benutzer
  ####################################################################
  users.users."soto" = {
    isNormalUser = true;
    description = "soto";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  ####################################################################
  # Desktop Environment & Session Manager (Hyprland + Greetd)
  ####################################################################
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  programs.uwsm.enable = true;

  # Greetd: Fragt immer nach User + Passwort und startet danach sofort Hyprland
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd '${pkgs.uwsm}/bin/uwsm start hyprland-uwsm.desktop'";
        user = "greeter";
      };
    };
  };

  # XDG Portale (Sauber aufgeteilt, Hyprland-Portal kommt automatisch)
  xdg.portal = {
    enable = true;
    config.common.default = [ "hyprland" "gtk" ];
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Standardterminal festlegen
  xdg.terminal-exec = {
    enable = true;
    settings.default = [ "alacritty.desktop" ];
  };

  xdg.mime = {
    enable = true;
    defaultApplications = {
      "text/markdown" = "micro-terminal.desktop";
      "text/plain" = "micro-terminal.desktop";
    };
  };

  programs.nano.enable = false; # Nano deaktivieren

  ####################################################################
  # Styling & Themes (GTK & Qt)
  ####################################################################
  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };

  programs.dconf.enable = true;
  programs.dconf.profiles.user.databases = [{
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        gtk-theme = "Colloid-Dark";
        cursor-theme = "McMojave-cursors";
        icon-theme = "Papirus-Dark";
      };
    };
  }];

  environment.etc."xdg/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=Colloid-Dark
    gtk-icon-theme-name=Papirus-Dark
    gtk-application-prefer-dark-theme=1
    gtk-cursor-theme-name=McMojave-cursors
    gtk-cursor-theme-size=24
  '';

  environment.etc."xdg/user-dirs.defaults".text = ''
    [Settings]
    DESKTOP=Desktop
    DOWNLOAD=Downloads
    DOCUMENTS=Documents
    MUSIC=Music
    PICTURES=Pictures
    VIDEOS=Videos
  '';

  ####################################################################
  # Umgebungsvariablen
  ####################################################################
  environment.variables = {
    NIXOS_OZONE_WL = "1";
    GTK_THEME = "Colloid-Dark";
    EDITOR = "alacritty -e micro";
    VISUAL = "alacritty -e micro";
    SUDO_EDITOR = "micro";
  };

  ####################################################################
  # Schriftarten
  ####################################################################
  fonts.packages = with pkgs; [
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
    nerd-fonts.monaspace
    nerd-fonts.symbols-only
  ];

  environment.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_10_0}/share/dotnet";
  };
  programs.nix-ld.enable = true;

  ####################################################################
  # Appimages
  ####################################################################
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  ####################################################################
  # Games
  ####################################################################
  programs.steam = {
    enable = true;
  };

  ####################################################################
  # Systemweite Software-Pakete
  ####################################################################
  environment.systemPackages = with pkgs; [
    # 🌐 Internet & Kommunikation
    firefox
    thunderbird
    signal-desktop
    teams-for-linux

    # 🧠 Produktivität & Wissen
    super-productivity
    anki

    # 🧾 Office & Dokumente
    libreoffice
    evince
    pdfarranger
    xournalpp

    # 💻 Editoren & Entwicklung
    micro
    alacritty
    neovim

    # Rofi fix: Run Micro inside Alacritty for .md files
    (pkgs.makeDesktopItem {
      name = "micro-terminal";
      desktopName = "Micro Text Editor";
      exec = "alacritty -e micro %F";
      icon = "micro";
      terminal = false;
      mimeTypes = [ "text/markdown" "text/plain" ];
      categories = [ "Utility" "TextEditor" ];
    })

    # 🛠️ Terminal & CLI
    git
    curl
    lazygit

    # 🖼️ Grafik & Design
    inkscape
    gimp
    feh

    # 📸 Screenshots
    grim
    slurp
    satty

    # 🎵 Audio
    pavucontrol
    spotify
    songrec
    tenacity

    # 🎬 Medien
    vlc
    mpv
    obs-studio
    shotcut

    # 🎨 Themes & Styling
    nwg-look
    gtk3
    gtk-layer-shell
    papirus-icon-theme
    (colloid-gtk-theme.override {
      tweaks = [ "black" ];
      colorVariants = [ "dark" ];
    })

    # 🧊 Hyprland Core Tools
    hyprpaper
    hyprlock
    hypridle

    # 🖥️ Desktop UI
    rofi
    rofimoji
    dunst
    libnotify

    # 📁 Dateimanagement
    nemo
    nautilus
    file-roller

    # 📊 Systemmonitoring
    btop
    brightnessctl
    playerctl

    # 🎨 Einstellungen & Backend
    dconf-editor
    font-manager
    wl-clipboard

    # 🌐 Netzwerk-Helfer
    rofi-network-manager

   # Java
    jdk21
    jdt-language-server

    # C#
    dotnet-sdk_10
    csharp-ls

    # Markdown bxb
    marksman
    prettier

    # HTML / CSS
    vscode-langservers-extracted
  ];
}
