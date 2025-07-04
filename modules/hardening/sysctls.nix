{
  pkgs,
  lib,
  config,
  ...
}:

let
  inherit (lib) mkForce mkIf;
in
{

  boot.kernel.sysctl = {
    # --- Critical Security Settings (Enforced) ---
    "kernel.kptr_restrict" = mkForce 2; # Restricts exposing kernel pointers
    "kernel.dmesg_restrict" = mkForce 1; # Restricts dmesg access to privileged users
    "kernel.unprivileged_bpf_disabled" = mkForce 1; # Disable unprivileged BPF (consider if needed for some tools)
    "kernel.yama.ptrace_scope" = mkForce 1; # Restrict ptrace to appropriate relationships
    "fs.suid_dumpable" = mkForce 0; # Prevent SUID binaries from being dumped
    "kernel.core_uses_pid" = mkForce 1; # Append PID to core dump filenames
    "kernel.sysrq" = mkForce 0; # Disable SysRq key (can be a security risk if console is accessible)

    # --- Memory Randomization (Enforced) ---
    "kernel.randomize_va_space" = mkForce 2; # Full ASLR
    "vm.mmap_rnd_bits" = mkForce 32; # ASLR bits for mmap (for 64-bit)
    "vm.mmap_rnd_compat_bits" = mkForce 16; # ASLR bits for mmap (for 32-bit compat)
    "vm.legacy_va_layout" = mkForce 0; # Disable legacy virtual address layout

    # --- Filesystem Protections (Enforced) ---
    "fs.protected_hardlinks" = mkForce 1;
    "fs.protected_symlinks" = mkForce 1;
    "fs.protected_fifos" = mkForce 2; # Root can only write
    "fs.protected_regular" = mkForce 2; # Root can only write

    # --- Network Hardening (IPv4 - Enforced) ---
    "net.ipv4.tcp_syncookies" = mkForce 1; # Help protect against SYN flood attacks
    "net.ipv4.tcp_timestamps" = mkForce 0; # Disable TCP timestamps (can leak uptime)
    "net.ipv4.conf.default.rp_filter" = mkForce 1; # Enable Reverse Path Filtering
    "net.ipv4.conf.all.rp_filter" = mkForce 1;
    "net.ipv4.conf.default.accept_source_route" = mkForce 0; # Disable source routing
    "net.ipv4.conf.all.accept_source_route" = mkForce 0;
    "net.ipv4.conf.default.accept_redirects" = mkForce 0; # Don't accept ICMP redirects
    "net.ipv4.conf.all.accept_redirects" = mkForce 0;
    "net.ipv4.conf.default.secure_redirects" = mkForce 1; # Accept secure ICMP redirects (from gateways known in routing table)
    "net.ipv4.conf.all.secure_redirects" = mkForce 1;
    "net.ipv4.conf.default.send_redirects" = mkForce 0; # Don't send ICMP redirects
    "net.ipv4.conf.all.send_redirects" = mkForce 0;
    "net.ipv4.icmp_echo_ignore_broadcasts" = mkForce 1; # Ignore broadcast pings
    "net.ipv4.icmp_ignore_bogus_error_responses" = mkForce 1; # Ignore bogus ICMP errors
    "net.ipv4.conf.all.log_martians" = mkForce 1; # Log martian packets
    "net.ipv4.conf.default.log_martians" = mkForce 1;
    "net.ipv4.ip_forward" = mkForce 0; # Disable IP forwarding unless this is a router
    "net.ipv4.tcp_rfc1337" = mkForce 1; # Protect against time-wait assassination
    "net.ipv4.conf.default.drop_gratuitous_arp" = mkForce 1;
    "net.ipv4.conf.all.drop_gratuitous_arp" = mkForce 1;
    "net.ipv4.ip_default_ttl" = mkForce 64; # Standard TTL
    "net.ipv4.tcp_ecn" = mkForce 1;
    # Enable ECN (Explicit Congestion Notification) for robustness, usually fine.
    # Set to 0 if it causes issues on strange networks.
    # "net.ipv4.tcp_sack" = mkForce 1; # SACK is generally good for performance. Already default on most kernels.
    # "net.ipv4.tcp_window_scaling" = mkForce 1; # Window scaling is essential for modern networks. Already default.

    # --- Network Hardening ---
    "net.ipv6.conf.all.accept_ra" = mkForce 0; # Don't accept Router Advertisements if not needed (e.g., static config)
    "net.ipv6.conf.default.accept_ra" = mkForce 0;
    "net.ipv6.conf.all.accept_redirects" = mkForce 0; # Don't accept ICMPv6 redirects
    "net.ipv6.conf.default.accept_redirects" = mkForce 0;

    # --- Performance and Debugging Related (Enforced) ---
    "kernel.perf_event_paranoid" = mkForce 3; # Disallow unprivileged access to perf events
    "dev.tty.ldisc_autoload" = mkForce 0; # Prevent TTY line discipline autoloading (security)

    # --- Kernel Panic Behavior (Enforced) ---
    "kernel.panic_on_oops" = mkForce 1;
    "kernel.panic_on_warn" = mkForce 1;
    "kernel.softlockup_panic" = mkForce 1;
    "kernel.hardlockup_panic" = mkForce 1;

    # --- User Namespace ---
    # Set to 0 if you want to disable unprivileged user namespaces, common hardening advice.
    # Set to 1 if you need them for containers (Docker, Podman) or sandboxing (Bubblewrap, Flatpak).
    # This often conflicts with hardened kernel defaults if it sets it to 0.
    "kernel.unprivileged_userns_clone" = mkForce 1;
  };
}
