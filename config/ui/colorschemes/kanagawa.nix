{ config, lib, ... }:
{
  config = lib.mkIf (config.ui.theme == "kanagawa") {
    colorschemes.kanagawa = {
      enable = true;
      lazyLoad = {
        settings = {
          colorscheme = "kanagawa";
          before.__raw = ''
            function()
              vim.opt_global.cmdheight = ${builtins.toString config.globalOpts.cmdheight}
            end
          '';
        };
      };
      settings = {
        inherit (config.ui) transparent;
        override = ''
          function(colors)
            local theme = colors.theme
            local makeDiagnosticColor = function(color)
              local c = require("kanagawa.lib.color")
              return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
            end

            return {
              DiagnosticVirtualTextHint  = makeDiagnosticColor(theme.diag.hint),
              DiagnosticVirtualTextInfo  = makeDiagnosticColor(theme.diag.info),
              DiagnosticVirtualTextWarn  = makeDiagnosticColor(theme.diag.warning),
              DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
            }
          end
        '';
      };
    };
  };
}
