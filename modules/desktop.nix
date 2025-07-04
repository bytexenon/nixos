{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    font-awesome
    nerd-fonts.jetbrains-mono
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.displayManager.ly = {
    enable = true;
    settings = {
      animate = true;
      animation = "cmatrix";
      hide_borders = true;
    };
  };
}
