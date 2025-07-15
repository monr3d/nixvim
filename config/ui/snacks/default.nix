{ config, lib, ... }:
{
  imports = [
    ./dashboard.nix
    ./explorer.nix
    ./indent.nix
    ./input.nix
    ./lazygit.nix
    ./notifier.nix
    ./picker.nix
  ];

  config = {
    plugins.snacks = {
      enable = lib.mkIf config.ui.snacks.enable true;
      lazyLoad.settings.lazy = false;
      settings = {
        toggle.enabled = lib.mkDefault false;
        explorer.enabled = lib.mkDefault false;
        indent.enabled = lib.mkDefault false;
        input.enable = lib.mkDefault false;
        lazygit.enabled = lib.mkDefault false;
        notifier.enabled = lib.mkDefault false;
        picker.enabled = lib.mkDefault false;
      };
    };
  };
}
