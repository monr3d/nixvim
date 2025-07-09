{ config, lib, ... }:
{
  config = {
    plugins.indent-blankline = {
      enable = !lib.hasAttr "indent" config.plugins.snacks.settings;
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
