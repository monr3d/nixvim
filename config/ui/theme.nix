{ lib, ... }:
{
  imports = [
    ./colorschemes
  ];

  options.ui = {
    theme = lib.mkOption {
      type = lib.types.enum [
        "everforest"
        "kanagawa"
      ];
    };
    transparent = lib.mkEnableOption "transparent background";
  };

  config = {
    ui = {
      theme = lib.mkDefault "kanagawa";
      transparent = lib.mkDefault true;
    };

    globalOpts = {
      winborder = "rounded";
    };
  };
}
