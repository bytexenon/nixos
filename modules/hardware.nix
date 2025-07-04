{ config, pkgs, ... }:

{
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.keyd = {
    enable = true;
    keyboards = {
      defaults = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "layer(shift)";
          };
        };
      };
    };
  };
}
