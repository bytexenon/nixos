{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.timesyncd = {
    enable = true;
    servers = [
      "0.nixos.pool.ntp.org"
      "1.nixos.pool.ntp.org"
      "ntp.example.com"
    ];
  };

  networking.hostName = "nixos";
  networking.nameservers = [
    "1.1.1.1#cloudflare-dns.com"
    "1.0.0.1#cloudflare-dns.com"
    "9.9.9.9#dns.quad9.net"
    "149.112.112.112#dns.quad9.net"
  ];
  services.resolved = {
    enable = true;
    llmnr = "false";
    dnsovertls = "true";
    dnssec = "true";
    fallbackDns = [
      "1.1.1.1"
      "9.9.9.9"
    ];
    domains = [ "~." ];
    extraConfig = ''
      MulticastDNS=no
    '';
  };

  # Open ports in the firewall.
  networking.nftables.enable = true;
  networking.firewall.enable = false;
  networking.nftables.ruleset = "";

  boot.kernelModules = [
    "nf_tables" # Core nf_tables module
    "nft_compat" # For iptables compatibility with nf_tables
  ];
}
