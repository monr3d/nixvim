{ config, lib, ... }:
{
  config = {
    plugins.snacks.lazyLoad.settings.keys =
      # [
      #   # Static keybindings that are always included
      #   {
      #     __raw = "{ "<leader>c", function() MyCustomFunc() end, desc = "Custom Command" }";
      #   }
      # ] ++
      lib.optional (! (builtins.elem "explorer" config.ui.snacks.exclude)) {
        __raw = "{ '<leader>e', function() Snacks.explorer() end, desc = 'File [e]xplorer' }";
      };
  };
}
