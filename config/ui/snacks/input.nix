{ config, lib, ... }:
{
  config = lib.mkIf (!builtins.elem "input" config.ui.snacks.exclude) {
    plugins.snacks = {
      settings.input = {
        enabled = true;
      };
    };
  };
}
