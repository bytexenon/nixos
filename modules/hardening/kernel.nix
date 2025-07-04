{ pkgs, lib, ... }:

let
  inherit (lib)
    mkForce
    ;
in
{
  # Hardened Linux Kernel
  # TODO: https://github.com/NixOS/nixpkgs/issues/97682
  # boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_hardened;
  # security.allowUserNamespaces = mkForce true;

  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/profiles/hardened.nix#L74
  boot.blacklistedKernelModules = [
    # Obscure network protocols
    "ax25"
    "netrom"
    "rose"

    # Old or rare or insufficiently audited filesystems
    "adfs"
    "affs"
    "bfs"
    "befs"
    "cramfs"
    "efs"
    "erofs"
    "exofs"
    "freevxfs"
    "f2fs"
    "hfs"
    "hpfs"
    "jfs"
    "minix"
    "nilfs2"
    "ntfs"
    "omfs"
    "qnx4"
    "qnx6"
    "sysv"
    "ufs"
  ];

  boot.kernelParams = [
    # Don't merge slabs
    "slab_nomerge"

    # Overwrite free'd pages
    "page_poison=1"

    # Enable page allocator randomization
    "page_alloc.shuffle=1"

    # Disable debugfs
    "debugfs=off"
  ];
}
