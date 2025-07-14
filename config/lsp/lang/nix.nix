{
  pkgs,
  self,
  system,
  ...
}:
{
  config = {
    extraPackages = with pkgs; [
      deadnix
      nix
      nixfmt-rfc-style
    ];

    plugins = {
      conform-nvim.settings = {
        formatters.nixfmt.command = "nixfmt";
        formatters_by_ft.nix = [ "nixfmt" ];
      };

      treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        nix
      ];

      lint = {
        linters = {
          deadnix.cmd = "deadnix";
          statix.cmd = "statix";
          nix.cmd = "nix-instantiate";
        };
        lintersByFt.nix = [
          "statix"
          "deadnix"
          "nix"
        ];
      };
    };

    lsp.servers = {
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
}
