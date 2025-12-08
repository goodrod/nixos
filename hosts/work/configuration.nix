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
      "kiro-cli"
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
    (jetbrains.rider.override { jdk = pkgs.openjdk21; })
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
      MIIDKTCCAhGgAwIBAgIUQ3QLSu8yoZwvQIuWWT93YnP2xrkwDQYJKoZIhvcNAQEL
      BQAwKzETMBEGA1UECgwKSGVsaW9zVGVzdDEUMBIGA1UEAwwLSGVsaW9zIFRlc3Qw
      HhcNMjUwODA1MTEwODQ3WhcNMzUwNjE0MTEwODQ3WjArMRMwEQYDVQQKDApIZWxp
      b3NUZXN0MRQwEgYDVQQDDAtIZWxpb3MgVGVzdDCCASIwDQYJKoZIhvcNAQEBBQAD
      ggEPADCCAQoCggEBAMEnyUFM9e9zskG7Ol+nyCjITvOJvxT0BuaxInhNc2gu3tc2
      DUmQAZ51mpjo8cCMZrCBUukQaSBS/1g/rda/JJ9LhQpjemlmxQ5jd4Ri5hlVozdb
      eyV6HgsTOut5nW9sdLBXmIjJjcAgONKsYv79niLD5HsNM5BZ/mGM6JdqjzGM/kNy
      aMpn3YShE4bwBMO+hYf0bgaqk/Q9Wq4tHPFgXzdW4OuHZXISnn/FqrUj38hAB5Wb
      bAG+YlG1pH3YrCKJiS6E3V4wQWnsobhHDsu9gaXava0qailLJRith4yrZr3ZukX4
      cd6Sj5fmf/XGiuuntRblMIHrXEqG/mi6IvHoT+sCAwEAAaNFMEMwDgYDVR0PAQH/
      BAQDAgKkMBIGA1UdEwEB/wQIMAYBAf8CAQEwHQYDVR0OBBYEFKBA/0S1NjWCihCB
      2MhL5TGTfVivMA0GCSqGSIb3DQEBCwUAA4IBAQBFpE7tduV4aFtC6xztOW/275Nb
      35GiSRJwf5C1lsMvwpt52+1brkzO7wgUjv6sf5HsnO2kS+yZ4UONjLYCxPskkj3d
      Twb8/D7J9tRv1LY4bxGORQnqJIzIegld1qN0qSiQaLCbMSW0PnoS8Dm+K1MV2+yF
      zW9qA6df3KgAKdl+FWIoq7sm/fYujPOMmvnkVETE/py1/s+ReRUtTmYYpEXJg7mi
      dHrZJY8pANxO2LlUB+ZKtSs0mcZ+0w8QWeN8br66v4r7OsPnAtwXaSZWlpFFFVQ5
      uvrzvykBHEZh1j1ma1G4vE3YXP0czy2tPNcs/rxW7Rc2cIJatOiv7lCLFqN6
      -----END CERTIFICATE-----
    ''
    ''
      -----BEGIN CERTIFICATE-----
      MIIDUDCCAjigAwIBAgIBFjANBgkqhkiG9w0BAQsFADArMRMwEQYDVQQKDApIZWxp
      b3NUZXN0MRQwEgYDVQQDDAtIZWxpb3MgVGVzdDAeFw0yNTA4MDUxMTA4NTJaFw0y
      NjA4MDUxMTA4NTJaMB8xHTAbBgNVBAMMFGhvc3QuZG9ja2VyLmludGVybmFsMIIB
      IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmwdw69pSMgmlfKJHb4B08mpx
      qkgbJQ/91P6HzBjK6OoDmjVuNDwKEH9mNArYHDRsSYHXMSBzWQGq7tujlBn0Eln0
      pHnb+Q329IBjX8/lOWAknTUwalBJYHYcu/KXM0sIjowXMHQiSVjVX0doajOojxjI
      voClThkKOl7UhfPRgRV6c/DjnxF82n2IboRBxecF0D1+qXo+TDbL0qiaFrUeaGhd
      0yDF1HcUGYQvRD3U0BXw0yDbtqR72aICp5Of/xSCAd5pLJX54X1Zor2TbrH55PYj
      HtxpWjKJKaKzSFZ4sZtzD4ko6WtyPMlkCMYLJd5Qd/CHxu1BVCstyKeMxn2u8wID
      AQABo4GKMIGHMAkGA1UdEwQCMAAwDgYDVR0PAQH/BAQDAgWgMCoGA1UdEQQjMCGC
      CWxvY2FsaG9zdIIUaG9zdC5kb2NrZXIuaW50ZXJuYWwwHQYDVR0OBBYEFOumW7Rw
      SLY2NiICwC3Jv9alPTezMB8GA1UdIwQYMBaAFKBA/0S1NjWCihCB2MhL5TGTfViv
      MA0GCSqGSIb3DQEBCwUAA4IBAQBpX6y52oN9KstW6Xx6C21V73witbNV9QUMAMid
      QHlNGur2Sa1s85NC91zGO5ULklrU2BWxI7juGfty0Z5BGm1XlR5+3UjA7gPBruqF
      HAM2d4rXjFDPb6g/AODXRGbvVXpDtjieSVKHrLTs30BzGPu/v3JZGJRqHEaDCXi9
      tR5LNIIuoCW5SaV2oeqFav9pxCFT3UXcknNyhd+J2VcGQDwca8OQ9lhAaSSLZXtA
      b3KQjF1kok9L+G+dba3aMEHuSHqBZHr7841yiAffgMYLp8kn5qAyCyf0MlKONAHz
      QSstQvE8+u8P3pVkLvazikAjHZ3dC4080P372FqD7kc1pSpi
      -----END CERTIFICATE-----
    ''
    ''
    -----BEGIN CERTIFICATE-----
MIIDKTCCAhGgAwIBAgIUPI5wxE/MT1I6ZbbisdVJo5KNcFgwDQYJKoZIhvcNAQEL
BQAwKzETMBEGA1UECgwKSGVsaW9zVGVzdDEUMBIGA1UEAwwLSGVsaW9zIFRlc3Qw
HhcNMjUxMDIwMTM1NDA1WhcNMzUwODI5MTM1NDA1WjArMRMwEQYDVQQKDApIZWxp
b3NUZXN0MRQwEgYDVQQDDAtIZWxpb3MgVGVzdDCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAKKpTIByhp5IsK/0QtXWK0mLyAWOc+Nob3/li37j5/EREOJg
rw/eBoQ0AZGJW/JIr4b2zHk5Fq6Xz+9MMJnFIcAXxLE3v9+sJdIGYUDOb+4jT7NH
h+x294+5k7vHJGkJGw9JkE8E8TxppC3Cv9gK0qxrmJRk0sShoQ6MBihuKI2HX79B
inDDMiHuUoPVbLV4o+jtVsrY8/F5eNN63G12J8ptgkkYZ8CehhrSb3IkMz3NaRd5
/8/bkTZVJPTnWzJb2n9qIQH0UZblcQFzcl18N+MPKeEwoaoVlqllPGviDAWeKn3j
LGF1pACZlPdAlOOCsJcTq6KHTBEUc4/RFzxsr1ECAwEAAaNFMEMwDgYDVR0PAQH/
BAQDAgKkMBIGA1UdEwEB/wQIMAYBAf8CAQEwHQYDVR0OBBYEFG3Mk5QYaOAit0kH
05QTjxeJ8p/IMA0GCSqGSIb3DQEBCwUAA4IBAQBq+B8dLuCH9RWseE0Ib+ws/R+j
fD1iZvtpP93hAe8XWdXw51mbtlbiJ5yjXIfboYlMy7aoCfU5xVxSVi9Lt1qQa+uP
YcA4FaOvGoxpU22V1ITyLT6FysAYwXsGdgXmL4jXetQWNgJu1ktrUhq9e5z5D5Yr
/Q3vNKCDT0oK702loSKIGGc3hNq3lF8+6p7pe7SZhZVaBcwx55obWem+cwKdnWe/
oQDhASF/mnmMvm5c0nDUeySdfJSn5X30EpDB1NeyJWAVz0FeO8oLjD9JAuafp7b1
0HZNN8j4NWsdsq7fMGIv6Bmu0KmtWqmeTCWmFk7+w1xWNLMGs0Krq3O10+S7
-----END CERTIFICATE-----
    ''
    ''
    -----BEGIN CERTIFICATE-----
    MIIDKTCCAhGgAwIBAgIUPI5wxE/MT1I6ZbbisdVJo5KNcFgwDQYJKoZIhvcNAQEL
    BQAwKzETMBEGA1UECgwKSGVsaW9zVGVzdDEUMBIGA1UEAwwLSGVsaW9zIFRlc3Qw
    HhcNMjUxMDIwMTM1NDA1WhcNMzUwODI5MTM1NDA1WjArMRMwEQYDVQQKDApIZWxp
    b3NUZXN0MRQwEgYDVQQDDAtIZWxpb3MgVGVzdDCCASIwDQYJKoZIhvcNAQEBBQAD
    ggEPADCCAQoCggEBAKKpTIByhp5IsK/0QtXWK0mLyAWOc+Nob3/li37j5/EREOJg
    rw/eBoQ0AZGJW/JIr4b2zHk5Fq6Xz+9MMJnFIcAXxLE3v9+sJdIGYUDOb+4jT7NH
    h+x294+5k7vHJGkJGw9JkE8E8TxppC3Cv9gK0qxrmJRk0sShoQ6MBihuKI2HX79B
    inDDMiHuUoPVbLV4o+jtVsrY8/F5eNN63G12J8ptgkkYZ8CehhrSb3IkMz3NaRd5
    /8/bkTZVJPTnWzJb2n9qIQH0UZblcQFzcl18N+MPKeEwoaoVlqllPGviDAWeKn3j
    LGF1pACZlPdAlOOCsJcTq6KHTBEUc4/RFzxsr1ECAwEAAaNFMEMwDgYDVR0PAQH/
    BAQDAgKkMBIGA1UdEwEB/wQIMAYBAf8CAQEwHQYDVR0OBBYEFG3Mk5QYaOAit0kH
    05QTjxeJ8p/IMA0GCSqGSIb3DQEBCwUAA4IBAQBq+B8dLuCH9RWseE0Ib+ws/R+j
    fD1iZvtpP93hAe8XWdXw51mbtlbiJ5yjXIfboYlMy7aoCfU5xVxSVi9Lt1qQa+uP
    YcA4FaOvGoxpU22V1ITyLT6FysAYwXsGdgXmL4jXetQWNgJu1ktrUhq9e5z5D5Yr
    /Q3vNKCDT0oK702loSKIGGc3hNq3lF8+6p7pe7SZhZVaBcwx55obWem+cwKdnWe/
    oQDhASF/mnmMvm5c0nDUeySdfJSn5X30EpDB1NeyJWAVz0FeO8oLjD9JAuafp7b1
    0HZNN8j4NWsdsq7fMGIv6Bmu0KmtWqmeTCWmFk7+w1xWNLMGs0Krq3O10+S7
    -----END CERTIFICATE-----
    ''
    ''
    -----BEGIN CERTIFICATE-----
MIIDKTCCAhGgAwIBAgIUfPM8URr5bR6jJPBa9rX9vXqFg2UwDQYJKoZIhvcNAQEL
BQAwKzETMBEGA1UECgwKSGVsaW9zVGVzdDEUMBIGA1UEAwwLSGVsaW9zIFRlc3Qw
HhcNMjUxMDIzMTAzNDI3WhcNMzUwOTAxMTAzNDI3WjArMRMwEQYDVQQKDApIZWxp
b3NUZXN0MRQwEgYDVQQDDAtIZWxpb3MgVGVzdDCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBANpXgdDv0NZ2srlKxkMtsWeixmObg2qneFh8BpDYGrpIcHXC
E6gp3LSVODbN+xtuS79CmNAIFEu0AD0+eqkuYOwJ3nioQwo1R2NmeBGYfz/TWv83
pG5smHMyuMhTYqdMLo/Y9jb9dg45K+viqEMwwOe5I1DJ6z+s9MSDtZTUmVCZ4az6
qG6rOF+jqMroVudNy7howX8hAUx1Bnpfh/dn4B0L7kOUFaNBWDdvPB4/A4BjhXKd
Jc4VVhjAtWLC/8iQymhTP8LTGx+/jn8gnmv1WZkys81MYFVCBpPJzuBZStLZH2bv
Yjso19ySOte0ubgkb+FhE7/RS93aKiIc9FLs+8kCAwEAAaNFMEMwDgYDVR0PAQH/
BAQDAgKkMBIGA1UdEwEB/wQIMAYBAf8CAQEwHQYDVR0OBBYEFGhzAEbU8M5gSycb
XTGm3CfoU7AKMA0GCSqGSIb3DQEBCwUAA4IBAQBk2tr+Q//3WV7lbFxAzeHc1F83
Y29xuKPlQUrl+YV5i9MmpIRqUzCOvg1C1UIUGIyyNVq31jzEG6lDcxiTb7v5N0H3
zlSRmxhiphhqNDp9/t1GKqblYzG3CkcOJNZbFuSpf4gQC+a2BCgee/qja/WUfPBq
J2zDV5M8U5pNCMPO8kFqWiAETSmsb2IkINDKxp2m8iEIIS6ejF5BPVtNzrzfxe68
mvjcwqIPiNxkFq9EiArXqJf0ZmsZKpw72JpIPKOdiwkdieml0Xr3pJ4r6oOswYvw
fCo32HlSXT/InWV2rjbL1yKfcBJwpGiZcOHS/JR9LBSChGdHpRYvgfVkqNlW
-----END CERTIFICATE-----
''
''
-----BEGIN CERTIFICATE-----
MIIDKTCCAhGgAwIBAgIUfPM8URr5bR6jJPBa9rX9vXqFg2UwDQYJKoZIhvcNAQEL
BQAwKzETMBEGA1UECgwKSGVsaW9zVGVzdDEUMBIGA1UEAwwLSGVsaW9zIFRlc3Qw
HhcNMjUxMDIzMTAzNDI3WhcNMzUwOTAxMTAzNDI3WjArMRMwEQYDVQQKDApIZWxp
b3NUZXN0MRQwEgYDVQQDDAtIZWxpb3MgVGVzdDCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBANpXgdDv0NZ2srlKxkMtsWeixmObg2qneFh8BpDYGrpIcHXC
E6gp3LSVODbN+xtuS79CmNAIFEu0AD0+eqkuYOwJ3nioQwo1R2NmeBGYfz/TWv83
pG5smHMyuMhTYqdMLo/Y9jb9dg45K+viqEMwwOe5I1DJ6z+s9MSDtZTUmVCZ4az6
qG6rOF+jqMroVudNy7howX8hAUx1Bnpfh/dn4B0L7kOUFaNBWDdvPB4/A4BjhXKd
Jc4VVhjAtWLC/8iQymhTP8LTGx+/jn8gnmv1WZkys81MYFVCBpPJzuBZStLZH2bv
Yjso19ySOte0ubgkb+FhE7/RS93aKiIc9FLs+8kCAwEAAaNFMEMwDgYDVR0PAQH/
BAQDAgKkMBIGA1UdEwEB/wQIMAYBAf8CAQEwHQYDVR0OBBYEFGhzAEbU8M5gSycb
XTGm3CfoU7AKMA0GCSqGSIb3DQEBCwUAA4IBAQBk2tr+Q//3WV7lbFxAzeHc1F83
Y29xuKPlQUrl+YV5i9MmpIRqUzCOvg1C1UIUGIyyNVq31jzEG6lDcxiTb7v5N0H3
zlSRmxhiphhqNDp9/t1GKqblYzG3CkcOJNZbFuSpf4gQC+a2BCgee/qja/WUfPBq
J2zDV5M8U5pNCMPO8kFqWiAETSmsb2IkINDKxp2m8iEIIS6ejF5BPVtNzrzfxe68
mvjcwqIPiNxkFq9EiArXqJf0ZmsZKpw72JpIPKOdiwkdieml0Xr3pJ4r6oOswYvw
fCo32HlSXT/InWV2rjbL1yKfcBJwpGiZcOHS/JR9LBSChGdHpRYvgfVkqNlW
-----END CERTIFICATE-----
''
  ];
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = false;
  system.stateVersion = "23.11";
}
