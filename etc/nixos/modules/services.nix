{ pkgs, ... }:

{
  # Audio (PipeWire)
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true; # Wichtig für Sound in 32-Bit-Spielen / Steam
  };

  # Drucker + Netzwerkdruck
  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # System-Services
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.power-profiles-daemon.enable = true;

  # 🔐 Rechteverwaltung (GUI Apps mit Root-Rechten)
  security.polkit.enable = true;

  # LID - Laptop closing - Options: {
    # "suspend"                 -> Standby (Standard)
    # "ignore"                  -> ignorieren (nichts tun)
    # "lock"                    -> Bildschirm sperren
    # "poweroff"                -> herunterfahren
    # "reboot"                  -> neu starten
    # "halt"                    -> sofort stoppen (System halt)
    # "kexec"                   -> Kernel neu laden
    # "hibernate"               -> Ruhezustand (auf Disk speichern)
    # "hybrid-sleep"            -> Mischung aus suspend + hibernate
    # "suspend-then-hibernate"  -> erst Standby, später Hibernate
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

  # Virtualisierung
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
}
