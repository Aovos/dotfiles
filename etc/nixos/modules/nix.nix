{ ... }:

{
  # Nix Paketmanager-Einstellungen
  nix.settings = {
    # Erkennt identische Dateien im Nix-Store automatisch und verlinkt sie hart (Hardlinks).
    # Spart im Laufe der Zeit massiv Festplattenplatz (oft mehrere Gigabyte).
    auto-optimise-store = true;

    # Aktiviert moderne, experimentelle Nix-Funktionen (z.B. Flakes und den neuen nix-Befehl).
    # Das bereitet dein System optimal auf die Zukunft vor, falls du mal Flakes nutzen willst.
    experimental-features = [ "nix-command" "flakes" ];
  };

  # Automatische Müllabfuhr (Garbage Collection)
  nix.gc = {
    automatic = true;
    dates = "weekly"; # Löscht einmal pro Woche alten Datenmüll
    options = "--delete-older-than 14d"; # Reduziert auf 14 Tage (völlig ausreichend als Sicherheitsnetz)
  };

  # Unfreie Software erlauben (z.B. für proprietäre Treiber, Steam, Discord, Google Chrome)
  nixpkgs.config.allowUnfree = true;
}
