{ config, pkgs, lib, ... }:

{
  config = {
    programs.nixvim = {
      extraPlugins = with pkgs.vimPlugins; [ ChatGPT-nvim ];
      extraConfigLua = ''
                local config = {
                  api_key_cmd = 'cat /home/goodrod/personal/openai-apikey'
        	}
                require('chatgpt').setup(config)
      '';
    };
  };
}
