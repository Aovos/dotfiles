{ ... }:

{
  # NixOS Version
  system.stateVersion = "25.11";

  # Zeit
  time.timeZone = "Europe/Berlin";

  # Sprache
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

  # Tastatur
  console = {
    keyMap = "de";
    font = "Lat2-Terminus16"; # Ergänzung: Sorgt für eine scharfe Textdarstellung im tuigreet Login-Manager
  };

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # sudo aktivieren
  security.sudo.enable = true;
}
