{ config, lib, pkgs, ... }:
{
  config = lib.mkIf (! (builtins.elem "explorer" config.ui.snacks.exclude)) {
    dependencies.ripgrep.enable = true;

    extraPackages = with pkgs; [ fd ];

    plugins.snacks = {
      settings = {
        explorer = {
          enabled = true;
        };
        picker = {
          sources = {
            explorer = {
              layout = {
                preset = "sidebar";
                preview = false;
                layout.position = "right";
              };
            };
          };
        };
      };
    };
  };
}
