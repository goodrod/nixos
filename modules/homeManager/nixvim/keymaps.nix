{ config, pkgs, lib, ... }:

{
  config = {
    programs.nixvim = {
      globals.mapleader = " ";

      keymaps = [
        {
          mode = "";
          key = "j";
          action = "h";
        }
        {
          mode = "";
          key = "k";
          action = "j";
        }
        {
          mode = "";
          key = "l";
          action = "k";
        }
        {
          mode = "";
          key = "ö";
          action = "l";
        }
        {
          action = "<cmd>Telescope live_grep<CR>";
          key = "<leader>gf";
        }
        {
          mode = "n";
          action = "<CMD>Oil<CR>";
          key = "-";
        }
        {
          mode = "n";
          action = "<cmd>Telescope find_files<CR>";
          key = "<leader>pf";
        }
        {
          mode = "n";
          action = "<cmd>Telescope git_files<CR>";
          key = "<C-p>";
        }
      ];
    };
  };
}
