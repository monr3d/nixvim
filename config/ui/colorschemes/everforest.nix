{ config, lib, ... }:
{
  config = lib.mkIf (config.ui.theme == "everforest") {
    colorschemes.everforest = {
      enable = true;
      settings = {
        enable_italic = 1;
        background = "hard";
        sign_column_background = "grey";
        transparent_background = lib.mkIf config.ui.transparent 2;
      };
    };
  };
}
