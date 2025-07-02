{
  pkgs,
  self,
  system,
  ...
}:
{
  config = {
    extraPackages = with pkgs; [
      nixfmt-rfc-style
    ];

    plugins = {
      treesitter = {
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          nix
        ];
      };
    };

    lsp = {
      servers = {
        nixd = {
          enable = true;
          settings = {
            nixpkgs.expr = ''import (builtins.getFlake "${self}").inputs.nixpkgs { }'';
            options = {
              nixvim.expr = ''(builtins.getFlake "${self}").packages.${system}.default.options'';
            };
          };
        };
        statix.enable = true;
      };
    };
  };
}
