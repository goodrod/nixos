{ config, pkgs, lib, ... }:

{
  config = {
    programs.nixvim.plugins.harpoon = {
      enable = true;
      keymaps.addFile = "<leader>a";
      keymaps.toggleQuickMenu = "<C-e>";
      keymaps.navFile = {
        "1" = "<C-j>";
        "2" = "<C-k>";
        "3" = "<C-l>";
        "4" = "<C-ö>";
      };
    };
  };
}
