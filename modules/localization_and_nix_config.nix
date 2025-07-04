{ config, pkgs, ... }:

{
  time.timeZone = "Atlantic/Reykjavik";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  programs.nano.nanorc = ''
    set tabstospaces
    set tabsize 2
    set nowrap
    set nohelp
    set autoindent
  '';

  nix.settings.experimental-features = "nix-command flakes";
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;
  nix.settings.trusted-users = [
    "root"
    "aki"
  ];
}
