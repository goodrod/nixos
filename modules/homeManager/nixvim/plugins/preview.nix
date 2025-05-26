{ config, pkgs, lib, ... }: {
  config = {
    programs.nixvim = {
      extraPlugins = with pkgs.vimPlugins; [ preview-nvim ];
      extraConfigLua = ''
              require('preview').setup({
                previewers_by_ft = {
                  plantuml = {
                    name = 'plantuml_text',
                    renderer = { type = 'buffer', opts = { split_cmd = 'split' } },
                  },
        	},
        	render_on_write = true,
              })
      '';
    };
  };
}
