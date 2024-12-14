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
            ts_ls.enable = true;
            lua_ls = {
              enable = true;
              settings.telemetry.enable = false;
            };
          };
        };
      };
    };
  };
}
