{
  config,
  pkgs,
  lib,
  ...
}:

{
  environment.variables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      aki = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        shell = pkgs.zsh;
      };
      root = {
        hashedPassword = "*";
        shell = lib.mkForce null;
      };
    };
  };
}
