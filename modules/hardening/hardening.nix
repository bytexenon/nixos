{ pkgs, ... }:

{
  imports = [
    ./sysctls.nix
    ./kernel.nix
  ];

  security.virtualisation.flushL1DataCache = mkForce "always";

  security.apparmor.enable = mkForce true;
  security.apparmor.killUnconfinedConfinables = mkForce true;

  security.lockKernelModules = true;
  security.protectKernelImage = true;
  security.forcePageTableIsolation = mkDefault true;

  # -- Firewall -- #
  #networking = {
  #  firewall.enable = true;
  #  nftables = {
  #    enable = true;
  #  };
  #};
}
