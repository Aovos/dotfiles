{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ./modules/nix.nix
    ./modules/system.nix
    ./modules/boot.nix
    ./modules/hardware.nix
    ./modules/networking.nix
    ./modules/user.nix
    ./modules/services.nix
    ./modules/environment.nix
    ./modules/packages.nix
    ./modules/fonts.nix
    ./modules/java.nix
  ];
}
