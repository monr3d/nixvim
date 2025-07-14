{ lib, pkgs, ... }:
{
  config = {
    extraPackages = with pkgs; [
      jq
    ];

    filetype.pattern = {
      "flake.lock" = "json";
    };

    plugins = {
      conform-nvim.settings = {
        formatters.jq.command = "jq";
        formatters_by_ft.json = [ "jq" ];
      };

      treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        json
        jsonc
      ];

      schemastore = {
        enable = true;
        json.enable = true;
        yaml.enable = lib.mkDefault false;
      };

      lint = {
        linters.jsonlint.cmd = lib.getExe pkgs.nodePackages.jsonlint;
        lintersByFt.json = [ "jsonlint" ];
      };
    };

    lsp.servers.jsonls.enable = true;
  };
}
