{
  config,
  lib,
  options,
  pkgs,
  ...
}:

{
  system.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;
  imports = [
    ./hardware-configuration.nix

    ./modules/networking.nix
    ./modules/boot.nix
    ./modules/desktop.nix
    ./modules/users.nix
    ./modules/hardware.nix
    ./modules/services.nix
    ./modules/localization_and_nix_config.nix
    ./modules/packages.nix
  ];

  home-manager.users.aki = import ./home_manager/home_manager.nix;
}
