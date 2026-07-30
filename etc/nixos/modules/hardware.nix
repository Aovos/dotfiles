{ config, pkgs, ... }:

{
  # Aktiviert proprietäre Firmware für WLAN, Bluetooth und Grafikchips (wichtig für maximale Hardware-Kompatibilität)
  hardware.enableAllFirmware = true;

  # Bluetooth-Konfiguration
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true; # Schaltet Bluetooth beim Hochfahren des PCs automatisch ein
    settings = {
      General = {
        Experimental = true; # Zeigt den Akkustand von Kopfhörern an und verbessert das automatische Wiederverbinden
      };
    };
  };
  
  # Aktiviert das grafische Bluetooth-Applet (blueman-manager) für die Statusleiste
  services.blueman.enable = true;

  # Grafiktreiber-Konfiguration (wichtig für die Performance von Hyprland)
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Aktiviert 32-Bit-Grafikunterstützung (zwingend erforderlich für Steam und viele Spiele)
  };

  # SSD-Optimierung: Aktiviert den wöchentlichen fstrim-Dienst, um die Lebensdauer und Geschwindigkeit der SSD zu erhalten
  services.fstrim.enable = true;

  # Akkudienst: Ermöglicht es Diensten wie Waybar oder hypridle, den Akkustand des Laptops und von Bluetooth-Geräten auszulesen
  services.upower.enable = true;
}
