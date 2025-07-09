{ config, lib, ... }:
{
  config = lib.mkIf (!builtins.elem "indent" config.ui.snacks.exclude) {
    plugins.snacks = {
      settings.indent = {
        enabled = true;
        indent = {
          char = "┆";
        };
        scope = {
          # underline = true;
          only_current = true;
        };
      };
    };
  };
}
