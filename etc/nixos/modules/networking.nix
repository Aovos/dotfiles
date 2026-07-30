{ ... }:

{
  networking = {
    # Der Name deines PCs im Netzwerk
    hostName = "nixos";

    # Aktiviert den NetworkManager zur einfachen Verwaltung von WLAN und LAN
    networkmanager.enable = true;

    # Aktiviert die integrierte Firewall zum Schutz vor unbefugten Zugriffen
    firewall.enable = true;

    # Optimierung: Beschleunigt den Bootvorgang erheblich, da das System beim
    # Hochfahren nicht blockiert und wartet, bis eine IP-Adresse zugewiesen wurde.
    networkmanager.waitOnline.enable = false;
  };
}
