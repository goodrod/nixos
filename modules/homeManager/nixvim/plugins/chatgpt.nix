{ config, pkgs, lib, ... }: {
  config = {
    programs.nixvim = {
      extraPlugins = with pkgs.vimPlugins; [ gp-nvim ];
      extraConfigLua = ''
        local config = {
          openai_api_key = {
            "bash",
            "-c",
            "cat /home/goodrod/personal/openai-apikey"
          },
          openai = { 
            disable = false, 
            endpoint = "https://api.openai.com/v1/chat/completions", 
          }
        }
        require('gp').setup(config)
      '';
    };
  };
}
