{ inputs, ... }: 

{
  home-manager."dabidew" = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      modules = [
        ./home.nix
	inputs.self.outputs.modules.home-manager.default
      ];
    };
  };
}
