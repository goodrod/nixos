{ config, pkgs, lib, ... }:

{
  config = { programs.nixvim = { plugins.telescope = { enable = true; }; }; };
}
