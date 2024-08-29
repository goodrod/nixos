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
    kubectl
    k9s
    kubectx
    yamlfmt
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = false;
  security.pki.certificates = [
    ''
      Hercules Certificate
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
    ''
      Helios Test Certificate (misc)
      ==========================
      -----BEGIN CERTIFICATE-----
      MIIDKTCCAhGgAwIBAgIUAO1+mo/jz6QOmcZoZ6FOg1Rej7UwDQYJKoZIhvcNAQEL
      BQAwKzETMBEGA1UECgwKSGVsaW9zVGVzdDEUMBIGA1UEAwwLSGVsaW9zIFRlc3Qw
      HhcNMjQwODA1MDkyMjA0WhcNMzQwNjE0MDkyMjA0WjArMRMwEQYDVQQKDApIZWxp
      b3NUZXN0MRQwEgYDVQQDDAtIZWxpb3MgVGVzdDCCASIwDQYJKoZIhvcNAQEBBQAD
      ggEPADCCAQoCggEBAMlwlBY/LWn+Cv2iPKMqeQ3XC4BrbooJIeiDDA03Z4Ia4bO/
      eCaTrzsnq0szWuRgDzNmr8RQoFHlu7L7xx4ILT+Z/FtwewhhOxtKGjdTnq0TVTZo
      2DfMHpeniB9jUSZO4uzo8EY1dGvSHGkO2VqPoax9LsKlz0sB6+pOM++oT3fQRv+m
      1hQvm6s7xYfiR0Fk7bd6pVpSu87EYEOsRr/OxJIMpOZLvkdDonmMMcfTfyV7B5rQ
      jJmQCTusdFqKrf68q+o0JUl0sEsOzuMjCd+i5cgp+Pr/H5a+y0R4m9UWdNTPLr50
      fj0ygHB/8DONjXKfOL3nro8matUbelWzUsnRGV8CAwEAAaNFMEMwDgYDVR0PAQH/
      BAQDAgKkMBIGA1UdEwEB/wQIMAYBAf8CAQEwHQYDVR0OBBYEFPudbiBUhPaIQd2z
      qXLYdpj4kG8GMA0GCSqGSIb3DQEBCwUAA4IBAQB8o1k+q2BVOC5sJOcU8zoJTSIt
      e+QOVlvDPTdGIgVY1JquSWF7dUUIL+rMqGo8DcBMsIP3/Wn0nb1F/kppAepC2Wb7
      qcJfc6C6gc7gV1IM7UiEdXycYd+0U2Q7R0X69X+jhBVbqJG1d6XwUQxjBoLcE/w9
      OUvptZfuTm7mcLUtP3RbvIuOubJ3zJf0QuXFN3dAfTtslqhMLp9fMkaJ2HuX3jAM
      0kkPfuN6IZp8QnA4EhANq+aepeh7ruRWJ9d1+9NDRrlTld8VtVmQgwx4sOtlmiTl
      WbnsU6498HMDExeoIGqpXe36FROEUfNDm5eCGYw0pfU8sAJ4Zf/xVoUTX5nY
      -----END CERTIFICATE-----
    ''
    ''
      Helios Test Certificate (misc-main)
      ==========================
      -----BEGIN CERTIFICATE-----
      MIIDKTCCAhGgAwIBAgIUTUH2/BfPoJXLn7X3HPjl7+Gvhy8wDQYJKoZIhvcNAQEL
      BQAwKzETMBEGA1UECgwKSGVsaW9zVGVzdDEUMBIGA1UEAwwLSGVsaW9zIFRlc3Qw
      HhcNMjQwODE1MTQwNTQ4WhcNMzQwNjI0MTQwNTQ4WjArMRMwEQYDVQQKDApIZWxp
      b3NUZXN0MRQwEgYDVQQDDAtIZWxpb3MgVGVzdDCCASIwDQYJKoZIhvcNAQEBBQAD
      ggEPADCCAQoCggEBAMGmbde160Nli7KVIjMCsyo/xtLjwSsQUDNwhtS02iDIU/wV
      TCIn1y8T1QgPvyNvlf2zG4+fQaISpAraRCZxLDzCRfB2paqkTfcx05JGBYBJZxIt
      7Pb+fqBFJbCJFeJLvR3gtd3rAIN0qC3ERsDx34W79FgzQ/ZxrBssd+CvT6A5BeZc
      njsvmONMJevoZTeX+SO5ocKHOGfdtb4I3mt6JHRZwiKGUNacWXTy6NY4+PD1K1Qa
      MJS1OEFdDutzitg0AE38wSID7xNkRR/yBpdLvmBP+pysGh0YscERJ4RRfahV3fU9
      RoXtkJhDORdxRo18orfaYWiI3apDqwW9zPhHcxcCAwEAAaNFMEMwDgYDVR0PAQH/
      BAQDAgKkMBIGA1UdEwEB/wQIMAYBAf8CAQEwHQYDVR0OBBYEFE8hMWp1W4gmVQ88
      pQdIVxBDf+9pMA0GCSqGSIb3DQEBCwUAA4IBAQAdbtCT6Uk7UAfRbDzBeUHdRAk7
      miPUfqMpZCJDXYftWeClbaH94dmwi+vVqSRmKerUdGzmSacFL59B0uS7wJh8jgxs
      HdwX5MMOqMY+h622gx+/p2oGpiO4bRZ2ChWQXWhcXvV9qkQrbBJBR8q0zsg/5wiv
      AznZfD/vo5HLcfJYMcBAtQ6aka7SzdLfKCG02P4KYT8ESnkqagZxghbzcngZdFdi
      tQewoNBvZq4qQNvaLEzWlZP5lQKgXiHjDg1DyxuHjLfLHsDffBxTVwNPUnVdwhN3
      TXQ+cSprZtm36LMjskyGvgaG5Jj/zHsJlVwn5hmHFd1TDzwUa6TPmVVgys9+
      -----END CERTIFICATE-----
    ''
    ''
      Dotnet Developer Certificate
      ==========================
      -----BEGIN CERTIFICATE-----
      MIIDDDCCAfSgAwIBAgIIIoQy+JtrBMIwDQYJKoZIhvcNAQELBQAwFDESMBAGA1UE
      AxMJbG9jYWxob3N0MB4XDTI0MDUxNjIxMzQyOFoXDTI1MDUxNjIxMzQyOFowFDES
      MBAGA1UEAxMJbG9jYWxob3N0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
      AQEAk4UC+odMiTttneP7LgkLonYWxG1ZCuG1Zxp76jhIqpFSmFkE6kKYVywdqB8D
      jRVvOal+qtiZIypYyR2QRo20ZO+FWoPwglUYrVZv6OGF3iAbgSY3mKXNDZsa24zx
      p/j0d9RS4KooO/Bi1ZXBttHdE3fxDnP5b3bSKtb0cjtrmGcQoWyFGBI1xpgvHgQY
      yiDy/g6MOfbnAhkKpFeVQQUPer1LBJvlaRpXYjxDa1ixt75aCoHmAWjuis0iD6NC
      0eZzr6ZKaz7ZwdR3a0vO3VVsPY5BISoJZV1FgWYzoGA2ahtslyE82mcH0Uz2jIV8
      qfal7dTV0RhsmBWlFLIJIUJ0LwIDAQABo2IwYDAMBgNVHRMBAf8EAjAAMA4GA1Ud
      DwEB/wQEAwIFoDAWBgNVHSUBAf8EDDAKBggrBgEFBQcDATAXBgNVHREBAf8EDTAL
      gglsb2NhbGhvc3QwDwYKKwYBBAGCN1QBAQQBAjANBgkqhkiG9w0BAQsFAAOCAQEA
      BzIErw64pOl8If5C5qeBC5mx+AC7EawztryOIpV48UoVSJPDfLaRV/3J33up0QWd
      +I2zmdvTaVrtov6LWcrxY2VR1LGuhUc83ka4/qCIUBL5GZlSDzfQGOFqSL0cG5iO
      OqN7w4vENO1tBpwPoHcdOcMaztLVGA9AfAzC5b9gAjwgmVncuIYiFqTcYtEXma3a
      S8d+E7GABhd7uhhWCJ26CDrLQg2cdWgFeknCDLUC2tBWFUKi4FAy7qXLwTnd/RkX
      bByJfkPq5tWThDSH+eMvX2bYlUwcqV7c6kiTUFW8mvhS1dxt5JEleo0QKdcitDd7
      QEtlp7PHim45ZAyb7LUJfQ==
      -----END CERTIFICATE-----
    ''
  ];
  system.stateVersion = "23.11";
}
