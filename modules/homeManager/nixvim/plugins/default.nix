{ config, pkgs, lib, ... }:

{
  imports = [
    ./cmp.nix
    ./misc.nix
    ./notify.nix
    ./gruvbox.nix
    ./lsp.nix
    ./harpoon.nix
    ./nvim-comment.nix
    ./misc.nix
    ./chatgpt.nix
    ./which-key.nix
    ./preview.nix
    ./telescope.nix
  ];
}
