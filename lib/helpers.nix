{ inputs, ... }: {
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
