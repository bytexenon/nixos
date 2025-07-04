{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ly
    xdg-desktop-portal-gtk
    glib
    killall
    vim
    gnupg
    wireguard-tools

    adwaita-icon-theme
  ];
}
