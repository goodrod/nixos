# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, lib, inputs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  module.networking.enable = true;
  module.boot-loader.enable = true;
  module.location.enable = true;
  module.sound.enable = true;
  module.silent-boot.enable = true;
  services.printing.enable = true;
  module.icon-fonts.enable = true;
  module.hyprland.enable = true;
  module.nvidia.enable = false;
  module.docker.enable = true;
  module.ecryptfs.enable = true;
  module.home-manager = {
    enable = true;
    module-path = ./home.nix;
  };
  module.dotnet.enable = true;
  module.virtual-box.enable = true;
  module.clamav = {
    enable = true;
    on-access = {
      enable = true;
      home-directories-to-scan = [ "Downloads" "work/projects/external" "personal/projects/external" ".mozilla" ];
    };
  };
  networking.hosts = {
    "172.18.0.1" = [ "host.docker.internal" ];
    "172.17.0.1" = [ "host.docker.internal" ];
    "192.168.0.90" = [ "host.docker.internal" ];
    "127.19.0.13" = [ "host.docker.internal" ];
    "127.19.0.1" = [ "host.docker.internal" ];
    "127.18.0.1" = [ "host.docker.internal" ];
    "127.17.0.1" = [ "host.docker.internal" ];
    "127.0.0.1" = [ "host.docker.internal" ];
    "0.0.0.0" = [ "host.docker.internal" ];
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "slack"
      "rider"
      "spotify"
      "postman"
      "keymapp"
      "everdo"
      "Oracle_VM_VirtualBox_Extension_Pack"
      "jetbrains.idea-community-bin"
    ];

  # list packages installed in system profile. to search, run:
  environment.systemPackages = with pkgs; [
    jetbrains.idea-community-bin    
    xclip
    keyutils
    nss_latest
    everdo
    fzf
    icu
    unzip
    keymapp
    wlr-randr
    wlogout
    wget
    neovim
    git
    slack
    docker-compose
    alacritty
    mlocate
    home-manager
    bitwarden
    openconnect
    nixfmt-classic
    libnotify
    pavucontrol
    jetbrains.rider
    chromium
    openssl
    dive
    grimblast
    linuxKernel.packages.linux_5_4.wireguard
    wireguard-tools
    xwallpaper
    spotify
    postman
    okular
    nodejs
    cryptsetup
    ntfs3g
    dunst
    libnotify
    nwg-displays
    jsonfmt
    killall
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = false;
  security.pki.certificates = [
  ''
    Hercules
    ==========================
    -----BEGIN CERTIFICATE-----
    MIIDQzCCAiugAwIBAgIUWNK9Z+wtwCATNUpBz3VQ0vqPpY8wDQYJKoZIhvcNAQEL
    BQAwODEaMBgGA1UECgwRSGVyY3VsZXMgSGVsaXNvZnQxGjAYBgNVBAMMEUhlcmN1
    bGVzIEhlbGlzb2Z0MB4XDTI0MDUwMzExMDgzMVoXDTM0MDMxMjExMDgzMVowODEa
    MBgGA1UECgwRSGVyY3VsZXMgSGVsaXNvZnQxGjAYBgNVBAMMEUhlcmN1bGVzIEhl
    bGlzb2Z0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA1C2FdQS2vnTV
    5AOOWKuZt+V1ki1+2ek2KTcWv1CSMUF4UkBdPWqddgqcOtOB/MvdFqT5Zh1FRfWH
    pPUsItz5n29viMrXZDvAaDJoIlQGbqevYVOV7e+D7w9UtzM7d3t0sinRjdwS5anr
    KUmN1tl7E48lEworGwZKWXQwKomfCW+VOKaRjljamhZ1npFCJDEy0yHslqYIMI9M
    nr71rXx5Mr6cyW4elS3qcvTDIjKTwIpN1hZnf+I7H7/yV2H6vyTs9L5nzfFGeSmq
    vK1cQtma/O1h7sVH/ji+ysy8f3UBKRG0i1F8WgBtfDooh4Qoc8lCyaa1I3/jSYKF
    Mg8zgb2skQIDAQABo0UwQzAOBgNVHQ8BAf8EBAMCAqQwEgYDVR0TAQH/BAgwBgEB
    /wIBATAdBgNVHQ4EFgQUY6OVQzF9xzCfoyxDRwFHZFx/+JkwDQYJKoZIhvcNAQEL
    BQADggEBAM1Cg9otk0tvNWkzRmDvDo+aQQZKK71OTm+V55S9mM+l5JmupfC8d+5Y
    T0sw1k94dqXmVvkRTT1xle/bqmy51MEfZfY4WjyktyArid1wOb4CmAZjJaU0jf85
    VgCf5x+Js2OMoO/GKnC/El0dnVAlBAi7ip8O7YXthmRorCY/rSUOB32NS4xoUXdK
    IWwOYKFzUYLDnwtzaLr9q35WxNv+DuPrN6gNCaXHVAg6s0xUa2BVwhF0Ez2beCRM
    PfJL3BAn8HXFKxfROsb+8jTl/FnQfPhbVN8bfLEBPCcyxJFtnH1E6fBXDZ14+D/J
    EOBlEXj5uwOjdDK4i8zyfZYOqF0MQ8g=
    -----END CERTIFICATE-----
  ''
  ];
  system.stateVersion = "23.11";
}
