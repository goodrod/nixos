{ config, pkgs, lib, ... }:

{
  config = { programs.nixvim.plugins.harpoon = { enable = true; }; };
}
