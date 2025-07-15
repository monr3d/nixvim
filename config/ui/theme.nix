{ lib, ... }:
let
  snacksModules = [
    "dashboard"
    "explorer"
    "picker"
    "indent"
    "input"
    "notifier"
  ];
in
{
  imports = [
    ./colorschemes
    ./misc
    ./snacks
  ];

  options.ui = {
    theme = lib.mkOption {
      type = lib.types.enum [
        "everforest"
        "kanagawa"
      ];
    };

    transparent = lib.mkEnableOption "transparent background";

    snacks = {
      enable = lib.mkEnableOption "Enable Snacks UX";
      exclude = lib.mkOption {
        type = lib.types.listOf (lib.types.enum snacksModules);
        default = [ ];
      };
    };
  };

  config = {
    ui = {
      theme = lib.mkDefault "kanagawa";
      transparent = lib.mkDefault true;
      snacks = {
        enable = lib.mkDefault true;
        exclude = [
          "indent"
        ];
      };
    };

    globalOpts = {
      winborder = "rounded";
    };
  };
}
