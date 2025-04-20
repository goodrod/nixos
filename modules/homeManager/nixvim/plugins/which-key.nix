{ config, pkgs, lib, ... }: {
  config = { programs.nixvim = { plugins.which-key.enable = true; }; };
}
