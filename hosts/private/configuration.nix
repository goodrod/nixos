# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ ./hardware-configuration.nix inputs.home-manager.nixosModules.default ];


  # TODO network module
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  services.resolved = { enable = true; };

  # TODO: location module
  time.timeZone = "Europe/Stockholm";
  
  console.keyMap = "sv-latin1";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  module.clamav.enable = true;

  # TODO: Bootloader module.
  boot.loader.grub = {
    enable = true;
    useOSProber = true;
    device = "nodev";
    efiSupport = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # TODO: wyprland module
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.waybar = { enable = true; };
 
  environment.sessionVariables = {
    #WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    HYPERLAND_LOG_WLR = "1";
  };
  
  # TODO: Silent boot module
  boot.plymouth = {
    enable = true;
    theme = "breeze";
  };

  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [ nerdfonts font-awesome ];
  };

  # TODO: Login moduleg
  services.xserver = {
  enable = true;
  displayManager.setupCommands = ''
      ${pkgs.xorg.xrandr}/bin/xrandr --output DP-3 --mode 2560x1440 --rotate normal --rate 144 
      ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-A-2 --off
    '';
  };
  services.displayManager = {
    defaultSession = "hyprland";
    sddm = {
      enable = true;
      sugarCandyNix = {
        enable = true; # This set SDDM's theme to "sddm-sugar-candy-nix".
        settings = {
          ScreenWidth = 2560;
          ScreenHeight = 1440;
          FormPosition = "left";
          HaveFormBackground = true;
          PartialBlur = true;
          # ...
        };
      };
    };
  };

  # TODO: Nvidia module
  hardware = {
    opengl.enable = true;
    nvidia = {
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "555.42.02";
        sha256_64bit = "sha256-k7cI3ZDlKp4mT46jMkLaIrc2YUx1lh1wj/J4SVSHWyk=";
        sha256_aarch64 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
        openSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
        setting5sSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
        persistencedSha256 = lib.fakeSha256;
      };
    };
  };

  # TODO: Sound module
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # TODO: home manager module 
  users.users.dabidew = {
    isNormalUser = true;
    description = "David Lindskog Hedström";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs;
      [
        #  thunderbird
      ];
  };
  
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { "dabidew" = import ./home.nix; };
  };

  # TODO: why do I need these?
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  services.printing.enable = true;

  # TODO: Docker module
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  virtualisation.docker.daemon.settings = {
    data-root = "/home/dabidew/docker/";
  };
  virtualisation.containers.enable = true;
  users.extraGroups.docker.members = [ "dabidew" ];
  
  # TODO: dotnet module
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ dotnet-sdk_8 dotnet-sdk_7 ];

  # TODO: keep here?
  programs.firefox.enable = false;
  programs.dconf.enable = true;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "slack"
      "rider"
      "spotify"
      "postman"
      "keymapp"
      "everdo"
    ];

  # list packages installed in system profile. to search, run:
  environment.systemPackages = with pkgs; [
    clamav
    keymapp
    wget
    neovim
    git
    docker-compose
    alacritty
    mlocate
    home-manager
    bitwarden
    openconnect
    nixfmt-classic
    libnotify
    slack
    pavucontrol
    jetbrains.rider
    chromium
    openssl
    flameshot
    dive
    dotnet-sdk_8
    linuxKernel.packages.linux_5_4.wireguard
    wireguard-tools
    xwallpaper
    spotify
    postman
    okular
    kitty
    nodejs
    cryptsetup
    ntfs3g
    dunst
    libnotify
    rofi-wayland
    nwg-displays
  ];
 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = false;
  system.stateVersion = "23.11";
}
