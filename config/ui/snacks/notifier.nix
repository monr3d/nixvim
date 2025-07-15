{ config, lib, ... }:
{
  config = lib.mkIf (!builtins.elem "notifier" config.ui.snacks.exclude) {
    plugins.snacks = {
      settings.notifier = {
        enabled = true;
      };
    };
  };
}
