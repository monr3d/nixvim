{ pkgs, ... }:
{
  config = {
    plugins = {
      treesitter = {
        enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          regex
        ];
        settings = {
          highlight.enable = true;
          incremental_selection.enable = true;
        };
      };
      treesitter-context.enable = true;
    };
  };
}
