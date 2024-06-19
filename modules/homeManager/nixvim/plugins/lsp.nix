{ config, pkgs, lib, ... }:

{
  config = {
    programs.nixvim = {
      plugins = {
        friendly-snippets.enable = true;
        luasnip = {
          enable = true;
          fromVscode = [ { } ];
        };
        lsp = {
          enable = true;
          servers = {
            tsserver.enable = true;
            lua-ls = {
              enable = true;
              settings.telemetry.enable = false;
            };
          };
        };
      };
    };
  };
}
