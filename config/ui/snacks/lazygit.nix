{ config, lib, ... }:
{
  config = lib.mkIf (!builtins.elem "lazygit" config.ui.snacks.exclude) {
    dependencies.lazygit.enable = true;

    plugins.snacks.settings.lazygit.enabled = true;
  };
}
