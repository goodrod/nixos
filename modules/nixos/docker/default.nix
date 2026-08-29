{ config, pkgs, lib, inputs, ... }:
with lib;
let
  cfg = config.module.docker;
in {
  options.module.docker = {
    enable = mkEnableOption "docker";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [ docker-compose ];
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
    virtualisation.containers.enable = true;
    users.extraGroups.docker.members = [ "goodrod" ];
  };
}
