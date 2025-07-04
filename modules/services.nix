{ config, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  programs.gnupg.agent = {
    enable = true;
  };

  # Less logs (Faster boot time)
  services.journald.extraConfig = "SystemMaxUse=1G";
}
