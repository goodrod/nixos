{
  module.hyprland = {
    enable = true;
    monitors.middle = {
      name = "DP-1";
      workspace = 20;
      focusKey = "F4";
    };
    monitors.right = {
      name = "HDMI-A-1";
      settings = "preferred,2560x0,1.0";
      workspace = 30;
      focusKey = "F5";
    };
    startup-commands = [ "steam -tenfoot" ];
  };
  module.alacritty.enable = true;
  module.bash.enable = true;
  module.fuzzel.enable = true;
  module.bluetooth.enable = true;
  module.icon-fonts.enable = true;

  programs.home-manager.enable = true;
}
