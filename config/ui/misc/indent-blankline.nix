{ config, ... }:
{
  config = {
    plugins.indent-blankline = {
      enable = !config.plugins.snacks.settings.indent.enabled;
      settings = {
        exclude.filetypes = [
          "snacks_dashboard"
          "lspinfo"
          "packer"
          "checkhealth"
          "help"
          "man"
          "gitcommit"
          "''"
        ];
        indent.char = "┆";
        scope = {
          char = "┃";
        };
      };
    };
  };
}
