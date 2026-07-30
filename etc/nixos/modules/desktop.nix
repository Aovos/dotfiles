{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --sessions ${pkgs.uwsm}/share/wayland-sessions";
        user = "greeter";
      };
    };
  };

  xdg.portal = {
    enable = true;
    config.common.default = [ "hyprland" "gtk" ];
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [ "alacritty.desktop" ];
    };
  };
}
