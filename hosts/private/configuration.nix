{
  pkgs,
  ...
}:

{
  imports = [ ./common.nix ];

  # Modules from modules/nixos.
  module.tailscale.enable = true;
  module.home-manager = {
    enable = true;
    module-path = ./home.nix;
  };
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

  specialisation.gaming = {
    inheritParentConfig = false;
    configuration.imports = [ ./gaming.nix ];
  };

  # Everything not covered by a module of its own.
  hardware.keyboard.zsa.enable = true;
  services.printing.enable = true;
  services.atd.enable = true;
  programs.firefox.enable = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ stdenv.cc.cc.lib ];
  networking.firewall.enable = true;

  environment.systemPackages = with pkgs; [
    wireguard-tools
    bluetuith
    keymapp
  ];

  system.stateVersion = "23.11";
}
