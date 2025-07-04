{ pkgs, ... }:

{
  home.stateVersion = "24.11";

  home.username = "aki";
  home.homeDirectory = "/home/aki";

  services.flameshot = {
    enable = true;
    package = pkgs.flameshot.override {
      enableWlrSupport = true;
    };
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      fastfetch = "fastfetch --gpu-hide-type integrated";
    };
  };

  programs.gh.enable = true;
  programs.git = {
    enable = true;
    userName = "bytexenon";
    userEmail = "bytexenon@proton.me";
    signing = {
      key = "EE6417967D72713B285D247EE175C983069481D3";
      format = "openpgp";
    };
    extraConfig = {
      commit.gpgsign = true;
      tag.gpgsign = true;
      credential.helper = "store";
    };
  };

  home.packages = with pkgs; [
    xfce.thunar
    xfce.ristretto
    xfce.tumbler

    lua54Packages.lua
    lua54Packages.lux-lua
    lux-cli

    appimage-run

    nodejs_24
    gimp
    vlc

    tree

    jdk

    nixfmt-rfc-style

    wine64
    winetricks
    qbittorrent

    waybar
    keepassxc
    vscode
    cmatrix
    pavucontrol
    kitty
    fastfetch
    ungoogled-chromium
    rofi-wayland
    ncdu
    tor-browser
    btop
    unzip
    distrobox

    rustup
    # cargo
    # rustc
    # rustfmt
    # rust-analyzer

    obsidian

    git
    gcc
    jq
    wl-clipboard
    pinentry
    obs-studio

    (python312.withPackages (ps: [
      ps.pip
    ]))
  ];
}
