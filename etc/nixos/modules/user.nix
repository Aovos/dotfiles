{ ... }:

let
  # Benutzernamen hier eintragen (vor dem GitHub-Push anonymisieren)
  username = "HIER_USER_NAME_EINTRAGEN_!!!";
in
{
  # Benutzerkonfiguration
  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";

    # Systemgruppen für Netzwerk, Sudo (wheel) und Virtualisierung
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
  };
}
