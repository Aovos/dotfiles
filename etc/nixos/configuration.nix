{ config, pkgs, ... }:

{
  ####################################################################
  # Imports
  ####################################################################

  imports = [
    ./hardware-configuration.nix
  ];

  ####################################################################
  # Nix
  ####################################################################

  nix.settings = {
    auto-optimise-store = true;                           # Nix-Store automatisch optimieren
    experimental-features = [ "nix-command" "flakes" ];  # Flakes und neue Nix CLI
  };

  nix.gc = {
    automatic = true;                                    # Garbage Collection aktivieren
    dates = "weekly";                                    # Wöchentlich ausführen
    options = "--delete-older-than 14d";                 # Ältere Generationen entfernen
  };

  nixpkgs.config.allowUnfree = true;                     # Proprietäre Software erlauben

  ####################################################################
  # Boot
  ####################################################################

  boot.loader.systemd-boot.enable = true;                # Systemd-Bootloader
  boot.loader.efi.canTouchEfiVariables = true;           # EFI-Einträge verwalten

  ####################################################################
  # Netzwerk
  ####################################################################

  networking = {
    hostName = "nixos";                                  # Rechnername

    networkmanager.enable = true;                        # WLAN- und LAN-Verwaltung

    firewall.enable = true;                              # Firewall aktivieren
  };

  systemd.services.NetworkManager-wait-online.enable = false; # Bootvorgang beschleunigen

  ####################################################################
  # Zeit & Sprache
  ####################################################################

  time.timeZone = "Europe/Berlin";                       # Zeitzone

  i18n.defaultLocale = "en_US.UTF-8";                   # Standardsprache

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
    keyMap = "de";                                       # Deutsches Tastaturlayout (TTY)
    font = "Lat2-Terminus16";                            # Konsolenschriftart
  };

  services.xserver.xkb = {
    layout = "de";                                       # Deutsches Tastaturlayout
    variant = "";
  };

  ####################################################################
  # Hardware
  ####################################################################

  hardware.enableAllFirmware = true;                     # Zusätzliche Firmware laden

  hardware.bluetooth = {
    enable = true;                                       # Bluetooth aktivieren
    powerOnBoot = true;                                  # Bluetooth beim Start einschalten

    settings = {
      General = {
        Experimental = true;                             # Erweiterte Bluetooth-Funktionen
      };
    };
  };

  hardware.graphics = {
    enable = true;                                       # Grafikstack aktivieren
    enable32Bit = true;                                  # 32-Bit Grafikbibliotheken
  };

  ####################################################################
  # Benutzer
  ####################################################################

  users.users."USERNAME_HERE" = {
    isNormalUser = true;                                 # Normaler Benutzer
    description = "USERNAME_HERE";

    extraGroups = [
      "networkmanager"                                   # Netzwerkverwaltung
      "wheel"                                            # sudo-Rechte
      "libvirtd"                                         # Virtualisierung
    ];
  };

  ####################################################################
  # Sicherheit
  ####################################################################

  security = {
    sudo.enable = true;                                  # sudo aktivieren
    polkit.enable = true;                                # Rechteverwaltung für GUI-Anwendungen
    rtkit.enable = true;                                 # Echtzeitprioritäten für Audio
  };

  ####################################################################
  # Services
  ####################################################################

  services.displayManager.gdm.enable = true;             # GNOME Display Manager

  services.pipewire = {
    enable = true;                                       # PipeWire aktivieren
    audio.enable = true;                                 # Audio-Unterstützung
    pulse.enable = true;                                 # PulseAudio-Kompatibilität
    alsa.enable = true;                                  # ALSA-Unterstützung
    alsa.support32Bit = true;                            # 32-Bit Audio-Unterstützung
  };

  services.printing.enable = true;                       # Drucker-Unterstützung

  services.avahi = {
    enable = true;                                       # mDNS / Bonjour
    nssmdns4 = true;                                     # IPv4 Namensauflösung
    nssmdns6 = true;                                     # IPv6 Namensauflösung
    openFirewall = true;                                 # Firewall-Regeln öffnen
  };

  services.blueman.enable = true;                        # Bluetooth-Verwaltung

  services.gvfs.enable = true;                           # Netzwerk- und USB-Mounts

  services.udisks2.enable = true;                        # Laufwerksverwaltung

  services.upower.enable = true;                         # Akkuinformationen bereitstellen

  services.fstrim.enable = true;                         # SSD-Trim

  services.power-profiles-daemon.enable = true;          # Energieprofile

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";                          # Deckel schließen ignorieren
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

  ####################################################################
  # Virtualisierung
  ####################################################################

  programs.virt-manager.enable = true;                   # Virt-Manager

  virtualisation.libvirtd.enable = true;                 # Libvirt-Dienst

  ####################################################################
  # Desktop
  ####################################################################

  programs.hyprland = {
    enable = true;                                       # Hyprland aktivieren
    withUWSM = true;                                     # UWSM Integration
  };

  programs.uwsm.enable = true;                           # Universal Wayland Session Manager

  ####################################################################
  # Systemprogramme
  ####################################################################

  programs.dconf.enable = true;                          # GNOME Einstellungen

  programs.nano.enable = false;                          # Nano deaktivieren

  ####################################################################
  # XDG
  ####################################################################

  xdg.portal = {
    enable = true;                                       # Desktop-Portale

    config.common.default = [
      "hyprland"
      "gtk"
    ];

    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland                        # Hyprland-Portal
      xdg-desktop-portal-gtk                             # GTK-Portal
    ];
  };

  xdg.terminal-exec = {
    enable = true;                                       # Standardterminal definieren

    settings.default = [
      "alacritty.desktop"
    ];
  };

  ####################################################################
  # Qt
  ####################################################################

  qt = {
    enable = true;                                       # Qt-Theming aktivieren
    platformTheme = "gtk2";                              # GTK-Integration für Qt
    style = "gtk2";                                      # GTK-Optik übernehmen
  };

  ####################################################################
  # Umgebung
  ####################################################################

  environment.variables = {
    NIXOS_OZONE_WL = "1";                                # Electron-Anwendungen unter Wayland

    GTK_THEME = "Colloid-Dark";                          # GTK Theme

    EDITOR = "micro";                                    # Standardeditor
    VISUAL = "micro";                                    # GUI Editor
    SUDO_EDITOR = "micro";                               # Editor für sudoedit
  };

  environment.etc."xdg/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=Colloid-Dark
    gtk-icon-theme-name=Papirus-Dark
    gtk-application-prefer-dark-theme=1
    gtk-cursor-theme-name=McMojave-cursors
    gtk-cursor-theme-size=24
  '';

  environment.etc."xdg/user-dirs.defaults".text = ''
    DESKTOP=Desktop
    DOWNLOAD=Downloads
    DOCUMENTS=Documents
    MUSIC=Music
    PICTURES=Pictures
    VIDEOS=Videos
  '';

  ####################################################################
  # Dconf
  ####################################################################

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

  ####################################################################
  # Pakete
  ####################################################################

  environment.systemPackages = with pkgs; [

    # 🌐 Internet & Kommunikation
    firefox
    chromium
    freetube
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

    # 💻 Editoren & Entwicklung
    jetbrains.rider
    helix
    micro
    alacritty

    # 🛠️ Terminal & CLI
    git
    lazygit
    tmux
    fzf
    curl

    # 🖼️ Grafik & Design
    inkscape
    gimp

    # 📸 Screenshots
    grim
    slurp
    satty

    # 🎵 Audio
    pavucontrol
    spotify
    songrec

    # 🎬 Medien
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

    # 🧊 Hyprland
    hyprpaper
    hyprlock
    hypridle

    # 🖥️ Desktop
    rofi
    dunst

    # 📁 Dateien
    nemo
    nautilus
    file-roller
    xdg-user-dirs

    # 📊 Systemmonitoring
    mission-center
    btop
    brightnessctl
    playerctl

    # 🎨 Einstellungen
    dconf-editor
    font-manager

    # 🔌 Desktop-Backend
    glib
    dconf
    gsettings-desktop-schemas
    wl-clipboard

    # 🌐 Netzwerk
    rofi-network-manager
  ];

  ####################################################################
  # Schriftarten
  ####################################################################

  fonts.packages = with pkgs; [
    nerd-fonts.hack                                    # Hack Nerd Font
  ];

  ####################################################################
  # Systemversion
  ####################################################################

  system.stateVersion = "25.11";                       # Ursprüngliche NixOS-Version
}
