{ config, pkgs, lib, ... }:

{
  config = { programs.nixvim = { plugins = { treesitter.enable = true; }; }; };
}
