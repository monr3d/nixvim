{ config, lib, ... }:
{
  imports = [
    ./explorer.nix
  ];

  config = {
    plugins.snacks = {
      enable = lib.mkIf config.ui.snacks.enable true;
      lazyLoad.settings.lazy = false;
      settings.toggle.enabled = false;
    };
  };
}
