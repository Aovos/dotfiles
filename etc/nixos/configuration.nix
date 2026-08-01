{ config, pkgs, ... }:

{
  ####################################################################
  # Imports
  ####################################################################
  imports = [ 
    ./hardware-configuration.nix
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

  # NVIDIA-Karte komplett physisch abschalten für maximale Akkulaufzeit (Option A)
  boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
  boot.kernelParams = [ "nouveau.modeset=0" ];

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

  # Basis-Grafikstack aktivieren (Intel)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

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
  # GPU - NVIDIA (ZUKÜNFTIGES SETUP / AKTUELL ÜBER BLACKLIST DEAKTIVIERT)
  ####################################################################
  # services.xserver.videoDrivers = ["nvidia" "intel"];
  # hardware.nvidia = {
  #   modesetting.enable = true;
  #   open = false;
  #   nvidiaSettings = true;
  #   powerManagement.enable = true;
  #   powerManagement.finegrained = true;
  #   prime = {
  #     offload = {
  #       enable = true;
  #       enableOffloadCmd = true;
  #     };
  #     intelBusId = "PCI:0:2:0";
  #     nvidiaBusId = "PCI:1:0:0";
  #   };
  # };

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
  users.users."USERNAME_HERE" = {
    isNormalUser = true;
    description = "USERNAME_HERE";
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
    EDITOR = "micro";
    VISUAL = "micro";
    SUDO_EDITOR = "micro";
  };

  ####################################################################
  # Schriftarten
  ####################################################################
  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];

  ####################################################################
  # Systemweite Software-Pakete
  ####################################################################
  environment.systemPackages = with pkgs; [
    # 🌐 Internet & Kommunikation
    firefox
    chromium
    freetube
    thunderbird
    signal-desktop

    # 🧠 Produktivität & Wissen
    super-productivity
    marktext
    anki
    drawio

    # 🧾 Office & Dokumente
    libreoffice
    pdfarranger
    xournalpp

    # 💻 Editoren & Entwicklung
    helix
    micro
    alacritty

    # 🛠️ Terminal & CLI
    git
    tmux
    fzf
    curl

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
    dunst

    # 📁 Dateimanagement (Beide behalten für maximale Features!)
    nemo
    nautilus
    file-roller

    # 📊 Systemmonitoring
    mission-center
    btop
    brightnessctl
    playerctl

    # 🎨 Einstellungen & Backend
    dconf-editor
    font-manager
    wl-clipboard

    # 🌐 Netzwerk-Helfer
    rofi-network-manager
  ];
}
