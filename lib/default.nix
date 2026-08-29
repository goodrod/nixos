{ inputs, ... }:
{
  # One NixOS system, assembled from hosts/<hostname>/ plus every module in
  # modules/nixos. The nixos-hostname file it writes is what the rebuild
  # command reads to know which host it is on.
  mkHost = { hostname }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./../hosts/${hostname}/configuration.nix
        ./../modules/nixos
        inputs.home-manager.nixosModules.default
        { config.environment.etc.nixos-hostname = { text = "${hostname}"; }; }
      ];
    };
}
