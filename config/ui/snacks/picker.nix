{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf (!builtins.elem "picker" config.ui.snacks.exclude) {
    plugins.snacks.settings.picker.enabled = true;
  };
}
