{ config, lib, ... }:
{
  config = {
    plugins.mini-icons = lib.mkIf config.globals.have_nerd_font {
      enable = true;
      # mockDevIcons = true;
    };
    plugins.web-devicons.enable = true;
  };
}
