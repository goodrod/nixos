{ config, pkgs, lib, inputs, ... }: {

  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [ lua-language-server stylua ripgrep ];
    plugins = with pkgs.vimPlugins; [
      which-key-nvim
      oil-nvim
      mini-icons
      telescope-nvim
      neo-tree-nvim
      nvim-treesitter
      nvim-cmp
      luasnip
      nvchad-ui
      lualine-nvim
      gruvbox
    ];
  };

  xdg.configFile."nvim" = {
    recursive = true;
    source = ./nvim;
  };
}

