# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, lib, inputs, ... }:

{

  imports =
    [ ./hardware-configuration.nix inputs.home-manager.nixosModules.default ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-16014315-f533-43d4-9baa-7f3e06736ddf".device =
    "/dev/disk/by-uuid/16014315-f533-43d4-9baa-7f3e06736ddf";

  networking.hostName = "nixos"; # Define your hostname.
  networking.hosts = {
    "127.0.0.1" = [ "host.docker.internal" ];
    "0.0.0.0" = [ "host.docker.internal" ];
    "172.19.0.7" = [ "host.docker.internal" ];
  };
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
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
  services.displayManager = {
    sddm.enable = true;
    defaultSession = "none+awesome";
  };
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [ luarocks luadbi-mysql ];
    };
  };

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "se";
    xkb.variant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # wireplumber.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.goodrod = {
    isNormalUser = true;
    description = "David Lindskog Hedström";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs;
      [
        #  thunderbird
      ];
  };

  users.extraGroups.docker.members = [ "goodrod" ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { "goodrod" = import ./home.nix; };
  };

  # Install firefox.
  programs.firefox.enable = false;
  programs.dconf.enable = true;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "obsidian" "slack" "rider" "spotify" "postman" ];
  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #unstable.clamav
    #unstable.obsidian
    #unstable.keymapp
    wget
    neovim
    awesome
    git
    docker-compose
    pkgs.xorg.xrandr
    arandr
    alacritty
    autorandr
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
    nodejs
    #podman-tui
    #podman-compose
    #gparted
  ];
  virtualisation.containers.enable = true;
  #virtualisation = {
  #  podman = {
  #    dockerSocket.enable = true;
  #    enable = true;

  #    # Create a `docker` alias for podman, to use it as a drop-in replacement
  #    dockerCompat = true;

  #    # Required for containers under podman-compose to be able to talk to each other.
  #    defaultNetwork.settings.dns_enabled = true;
  #  };
  #};

  services.resolved = { enable = true; };
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  virtualisation.docker.daemon.settings = {
    data-root = "/home/goodrod/docker/";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
