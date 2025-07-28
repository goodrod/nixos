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
  module.discord.enable = false;
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
  programs.firefox.enable = true;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "slack"
      "rider"
      "discord"
      "spotify"
      "keymapp"
      "everdo"
      "Oracle_VM_VirtualBox_Extension_Pack"
      "postman"
      "obsidian"
      "vivaldi"
    ];

  # list packages installed in system profile. to search, run:
  environment.systemPackages = with pkgs; [
    ansible
    sshpass
    keyutils
    etcd_3_4
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

  security.pki.certificates = [
    ''
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
      -----END CERTIFICATE-----
    ''
    ''
      -----BEGIN CERTIFICATE-----
      MIIG6zCCBNOgAwIBAgITOQAAABBPhQX/d2L4awABAAAAEDANBgkqhkiG9w0BAQsF
      ADBsMRgwFgYKCZImiZPyLGQBGRYIaW50ZXJuYWwxGDAWBgoJkiaJk/IsZAEZFgho
      ZWxpc29mdDEUMBIGCgmSJomT8ixkARkWBHRlc3QxIDAeBgNVBAMTF3Rlc3QtV0lO
      LTg3SzNSOTVHNkZELUNBMB4XDTI1MDEwOTE1MTIxMVoXDTI3MDEwOTE1MTIxMVow
      IDEeMBwGA1UEAxMVaWRwLmhlbGlzb2Z0LmludGVybmFsMIIBIjANBgkqhkiG9w0B
      AQEFAAOCAQ8AMIIBCgKCAQEAyVHEn592ddashTRCafwr/0JxN21Rtb9hJbpOUztt
      VJI7fOIslOBLjfruFSjE/sm5E+fj4KTpgT9GcgzO6k6De2FmfCGej4CZm79DnaDl
      d070JGFNwhpnEUM+e1Zbh0K5UbsiFF9MPLqsUo+RfIVKrBb3GeR/JeWFmqiGuXsm
      YNMp8jYHI4N6YaV+PoGcpRA+3pEDl4IhwuVeo1QoltXtoZwA8WkQwfnnWR0rp40b
      usJmuRDEbD9UmuFuFOk9Mw988x0A1iaOOKRKR8XOfMYU/xgb1u4Pqm97XKkl4iC8
      QDdinti1NemgnPhbfVmYFGUG8j5kW9pMtRPxPodrgYA1TQIDAQABo4IC0DCCAsww
      PQYJKwYBBAGCNxUHBDAwLgYmKwYBBAGCNxUIhvGxAoPWgUiHgY02gq3LRoHssAgA
      guqIXIacoksCAWQCAQ0wEwYDVR0lBAwwCgYIKwYBBQUHAwEwDgYDVR0PAQH/BAQD
      AgWgMBsGCSsGAQQBgjcVCgQOMAwwCgYIKwYBBQUHAwEwHQYDVR0OBBYEFETbugvf
      pTXvIbO+jWQss1eWhS6SMB8GA1UdIwQYMBaAFJVo6UFE9fDYv8SQx5mz4edLrxWA
      MIIBLQYDVR0fBIIBJDCCASAwggEcoIIBGKCCARSGgddsZGFwOi8vL0NOPXRlc3Qt
      V0lOLTg3SzNSOTVHNkZELUNBKDEpLENOPVdJTi04N0szUjk1RzZGRCxDTj1DRFAs
      Q049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmln
      dXJhdGlvbixEQz10ZXN0LERDPWhlbGlzb2Z0LERDPWludGVybmFsP2NlcnRpZmlj
      YXRlUmV2b2NhdGlvbkxpc3Q/YmFzZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRp
      b25Qb2ludIY4aHR0cDovL3BraS5oZWxpc29mdC5pbnRlcm5hbC90ZXN0LVdJTi04
      N0szUjk1RzZGRC1DQS5jcmwwgdcGCCsGAQUFBwEBBIHKMIHHMIHEBggrBgEFBQcw
      AoaBt2xkYXA6Ly8vQ049dGVzdC1XSU4tODdLM1I5NUc2RkQtQ0EsQ049QUlBLENO
      PVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3Vy
      YXRpb24sREM9dGVzdCxEQz1oZWxpc29mdCxEQz1pbnRlcm5hbD9jQUNlcnRpZmlj
      YXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTANBgkq
      hkiG9w0BAQsFAAOCAgEAHgzG0DOwGEdg6OcpD+3pkP04MdsGc7u81LHcnA+juEUW
      bU+YhaNemfuArLdbV/jBF+Q6V09LgfrfPfPAHfGlYZsrRT3boamSS/xSHLBatHel
      a+q9p5Kksph93DxIpDuZ8xMEscq4StvTZvagqMi7iOoYTWFJFIzKFvqaxtkQaAXa
      1F9gw3XCTR9JMbtv+LdyK8o5WSZXfeY6+lL9rN3KAiNqJ8sx3Tgd95uyK8Lk+Dou
      Qv8mkus3nz9mhOolBeLIpana8V3mJOZeE1rbyXRhCX1LYahAAX4Ywq0R6j/Z7tnY
      6vZ4XZi/+I9M3vy/buRm7Vh+jYVVcBJFTma1zz/zqN0MDPfiEalX2E3vFl+mNoYz
      qzwes8Jwov9PZm1uHBUqtzUpZWro6wK4WgD+TAdmntO6i3QVy83OIaFSDuT8Erpd
      Ms88Fuzmu9jjtT/jVwfZJJqyUWTW0stFXK5PVXsFDSy3yzq+e2m1V7rBil/Ih3Yf
      XhKgLNokV5l+qlETSde/qoxeMaAeDwA47uh+cCpoY8eYQbVcHE2ry4EQdSWE8KIk
      +uTU6liFkmkI2IBiR/rpxTilm42l0xzxNN7tXRql+3+XvW5O/7uILc6xgSAhGoy5
      fE7tDCeSuhSsYpCZUl8XIUSF6Cw/SB/dwaof+s3hCpjIzZIKQDcFwnbaiL/Lraw=
      -----END CERTIFICATE-----''
  ];
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = false;
  system.stateVersion = "23.11";
}
