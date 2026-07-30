{ pkgs, ... }:

{
  environment.variables = {
    EDITOR = "micro";
    VISUAL = "micro";
    SUDO_EDITOR = "micro";
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    GTK_THEME = "Colloid-Dark";
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

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  environment.systemPackages = with pkgs; [
    adwaita-qt
    adwaita-qt6
    gnome-themes-extra
  ];

  system.activationScripts.microRootConfig = {
    text = ''
      mkdir -p /root/.config/micro
      for user_dir in /home/*; do
        if [ -d "$user_dir/.config/micro" ] && [ ! -L "$user_dir/.config/micro" ]; then
          ln -sfn "$user_dir/.config/micro/settings.json" /root/.config/micro/settings.json
          break
        fi
      done
    '';
  };

  programs.nano.enable = false;
}
