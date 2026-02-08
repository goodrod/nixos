{ inputs, ... }:
let libx = import ./../lib { inherit inputs; };
in {
  systems = [ "x86_64-linux" ];
  flake = {
    nixosConfigurations =
      inputs.nixpkgs.lib.attrsets.genAttrs [ "work" "private" ]
      (name: libx.mkHost { hostname = name; });
  };
}
