{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  inherit (types) nullOr str;
  settings = config.module.gaming;

  steam-gamescope-logged =
    let
      script = pkgs.writeShellScriptBin "steam-gamescope-logged" ''
        exec ${pkgs.systemd}/bin/systemd-cat -t steam-gamescope --stderr-priority=warning \
          gamescope --steam -- steam -tenfoot -pipewire-dmabuf
      '';
    in
    (pkgs.writeTextDir "share/wayland-sessions/steam-logged.desktop" ''
      [Desktop Entry]
      Name=Steam (logged)
      Comment=The gamescope session, with its output in the journal
      Exec=${script}/bin/steam-gamescope-logged
      Type=Application
    '').overrideAttrs
      (_: {
        passthru.providedSessions = [ "steam-logged" ];
      });
in
{
  imports = [
    ./battlenet.nix
    ./curseforge.nix
  ];

  options.module.gaming = {
    enable = mkEnableOption "gaming (steam under a gamescope session, proton, sched_ext)";

    scheduler = mkOption {
      type = nullOr str;
      default = "scx_lavd";
      description = ''
        sched_ext scheduler to hand the machine to, or null to keep the kernel
        default. Needs CONFIG_SCHED_CLASS_EXT, so kernel 6.12 or later.
      '';
    };
  };

  config = mkIf settings.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    programs.gamescope = {
      enable = true;
      enableWsi = true;
    };

    programs.gamemode.enable = true;

    services.displayManager.sessionPackages = [ steam-gamescope-logged ];

    services.scx = mkIf (settings.scheduler != null) {
      enable = true;
      scheduler = settings.scheduler;
    };

    environment.systemPackages = with pkgs; [
      mangohud
      protonup-qt
    ];
  };
}
