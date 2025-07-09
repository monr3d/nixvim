{ lib, config, ... }:
{
  imports = [
    ./completion/blink-cmp.nix
    ./lang
    ./treesitter.nix
  ];

  config = {
    diagnostic.settings = {
      severity_sort = true;
      signs = {
        text = lib.mkIf config.globals.have_nerd_font {
          "__rawKey__vim.diagnostic.severity.ERROR" = "";
          "__rawKey__vim.diagnostic.severity.WARN" = "";
          "__rawKey__vim.diagnostic.severity.HINT" = "";
          "__rawKey__vim.diagnostic.severity.INFO" = "󰌶";
        };
      };
      underline = {
        severity.__raw = ''vim.diagnostic.severity.ERROR'';
      };
      virtual_lines = {
        current_line = true;
      };
      virtual_text = {
        spacing = 2;
        source = "if_many";
        prefix = "●";
      };
    };

    plugins.lspconfig = {
      enable = true;
      lazyLoad.settings.event = "BufRead";
    };

    lsp = {
      inlayHints.enable = true;
      onAttach = ''
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, bufnr) then

          local highlight_group = vim.api.nvim_create_augroup("LspHighlight_" .. bufnr, { clear = false })

          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = highlight_group,
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            group = highlight_group,
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("nixvim_lsp_on_detach" .. bufnr, { clear = true }),
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = LspHighlight_, buffer = bufnr })
            end,
          })
        end

        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, bufnr) then
          vim.keymap.set('n', '<leader>lt', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr }))
          end, { desc = 'Toggle Inlay Hints', buffer = bufnr })
        end
      '';
    };
  };
}
