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
  module.greetd.enable = true;
  module.home-manager = {
    enable = true;
    module-path = ./home.nix;
  };
  module.dotnet.enable = true;
  module.virtual-box.enable = false;
  module.clamav = {
    enable = true;
    on-access = {
      enable = true;
      home-directories-to-scan = [
        "Downloads"
        "work/projects/external"
        "personal/projects/external"
        ".mozilla"
      ];
    };
  };
  module.helios-development.enable = true;
  programs.firefox.enable = false;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "slack"
      "rider"
      "spotify"
      "keymapp"
      "everdo"
      "Oracle_VM_VirtualBox_Extension_Pack"
      "postman"
      "obsidian"
    ];

  # list packages installed in system profile. to search, run:
  environment.systemPackages = with pkgs; [
    ansible
    sshpass
    keyutils
    file
    nss_latest
    slack
    pavucontrol
    jetbrains.rider
    linuxKernel.packages.linux_5_4.wireguard
    wireguard-tools
    nodejs
    kubectl
    k9s
    kubectx
    chromium
    postman
    obsidian
    rpm
    bruno
  ];

  security.pki.certificates = [''
    -----BEGIN CERTIFICATE-----
        MIIDaTCCAlGgAwIBAgIBETANBgkqhkiG9w0BAQsFADA4MRowGAYDVQQKDBFIZXJj
        dWxlcyBIZWxpc29mdDEaMBgGA1UEAwwRSGVyY3VsZXMgSGVsaXNvZnQwHhcNMjQw
        NTAzMTEwODMyWhcNMjUwNTAzMTEwODMyWjAjMSEwHwYDVQQDDBhwb3J0YWwuaGVs
        aXNvZnQuaW50ZXJuYWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC8
        9Rx3FFcVCqae/zrMeuy5bE9nGszPTVO1x+AVXhurv2EzxJBLwZmVeKGnCBRxRIcB
        wOIsyDtL1O/DXZ4t8BcZ40ErKGM2LESuUn71IOtsDJPm8OF2Ky7NdbPKWVADI36q
        CddzEQOUaGl4sdAVdrqgrA89AzUle2b+zDfvglYhiZj19LfxVhQZ9J+iSOEanmOX
        eMgpYavM9MaKt/YJNwXKjx+ZWDX1NvFkOZgYlJnWwb9yKHvcf22rsWhXwbzETCcE
        1zqQpiX+glMyicV5KQrvmMpMVaXOnhTBvv5zr4wKgVZTzaG9h7/BVD0tCekpm+Zz
        CHcZgbh4PeOczQcjwhIlAgMBAAGjgZIwgY8wCQYDVR0TBAIwADAOBgNVHQ8BAf8E
        BAMCBaAwMgYDVR0RBCswKYIYcG9ydGFsLmhlbGlzb2Z0LmludGVybmFsgg0xOTIu
        MTY4LjcuMTgwMB0GA1UdDgQWBBQ/+SgQSYhpd7ufaIWxktrWqE1pojAfBgNVHSME
        GDAWgBRjo5VDMX3HMJ+jLENHAUdkXH/4mTANBgkqhkiG9w0BAQsFAAOCAQEAhSHt
        tA15V/KYn75oezTQKOpX/FyMEtYZnYXVG1d27zXYX8scohhO87qhaxREyotRwLWw
        rovWd3P2HYVkMUcF/JjJMGI/SQ8xQ55Ayat/CD8TywUp8mUgmEKEl7KpQSArPubf
        v2agNW+sfo+YB0QCnEs2m6Y68JHRMIdam3aBzcnLi71nqEzunA+eIhr7vo+Z1Amn
        khtW3MaVo4LPJY4ovrGDQfsMiPMlayxfC3Qa/etOy+VYOKwGB8KNeZMAQ5dTh8ct
        cBtvz+iAiVCS+LjEZbU5XyMah0uWQ1axoVhetRP4kWGb592l2Z1KFWLHBnyP0G62
        +XX+wlQ2bjZIRoVRIA==
        -----END CERTIFICATE-----''];
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = false;
  system.stateVersion = "23.11";
}
