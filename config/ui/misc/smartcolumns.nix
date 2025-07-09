{ config, ... }:
{
  config = {
    plugins.smartcolumn = {
      enable = true;
      lazyLoad.settings.event = "BufEnter";
      settings = {
        inherit (config.opts) colorcolumn;
        custom_colorcolumn = {
          nix = [
            "100"
            "120"
          ];
        };
        disabled_filetypes = [
          "snacks_dashboard"
          "snacks_picker_list"
          "checkhealth"
          "help"
        ];
      };
    };
  };
}
