{ config, lib, ... }:
{
  lsp = {
    keymaps = lib.flatten (
      [
        {
          key = "<leader>la";
          lspBufAction = "code_action";
          options = {
            desc = "Code Action";
          };
        }
        {
          key = "<leader>lh";
          lspBufAction = "hover";
          options = {
            desc = "Hover";
          };
        }
        {
          key = "<leader>lH";
          lspBufAction = "document_highlight";
          options = {
            desc = "Document Highlight";
          };
        }
        {
          key = "<leader>lr";
          lspBufAction = "rename";
          options = {
            desc = "Rename";
          };
        }
        {
          key = "<leader>ls";
          lspBufAction = "signature_help";
          options = {
            desc = "Signature Help";
          };
        }
        {
          key = "<leader>lwa";
          lspBufAction = "add_workspace_folder";
          options = {
            desc = "Add Folder";
          };
        }
        {
          key = "<leader>lwl";
          action.__raw = ''
            function()
              vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end
          '';
          options = {
            desc = "List Folders";
          };
        }
        {
          key = "<leader>lwr";
          lspBufAction = "remove_workspace_folder";
          options = {
            desc = "Remove Folder";
          };
        }
      ]
      ++ lib.optional (!config.plugins.conform-nvim.enable) [
        {
          key = "<leader>lf";
          lspBufAction = "format";
          options = {
            desc = "Format ";
          };
        }
      ]
      ++ lib.optional (builtins.elem "picker" config.ui.snacks.exclude) [
        {
          key = "<leader>lgd";
          lspBufAction = "definition";
          options = {
            desc = "Definition";
          };
        }
        {
          key = "<leader>lgD";
          lspBufAction = "declaration";
          options = {
            desc = "Declaration";
          };
        }
        {
          key = "<leader>lgi";
          lspBufAction = "implementation";
          options = {
            desc = "Implementation";
          };
        }
        {
          key = "<leader>lgr";
          lspBufAction = "references";
          options = {
            desc = "References";
            nowait = true;
          };
        }
        {
          key = "<leader>lgt";
          lspBufAction = "type_definition";
          options = {
            desc = "Type";
          };
        }
        {
          key = "<leader>lws";
          lspBufAction = "workspace_symbol";
          options = {
            desc = "Symbol";
          };
        }
        {
          key = "<leader>lS";
          lspBufAction = "document_symbol";
          options = {
            desc = "Document Symbol";
          };
        }
      ]
      ++ lib.optional (!(builtins.elem "picker" config.ui.snacks.exclude)) [
        {
          key = "<leader>lgd";
          action.__raw = ''
            function()
            Snacks.picker.lsp_definitions()
            end
          '';
          options = {
            desc = "Definition";
          };
        }
        {
          key = "<leader>lgD";
          action.__raw = ''
            function()
            Snacks.picker.lsp_declarations()
            end
          '';
          options = {
            desc = "Declaration";
          };
        }
        {
          key = "<leader>lgi";
          action.__raw = ''
            function()
            Snacks.picker.lsp_implementations()
            end
          '';
          options = {
            desc = "Implementation";
          };
        }
        {
          key = "<leader>lgr";
          action.__raw = ''
            function()
            Snacks.picker.lsp_references()
            end
          '';
          options = {
            desc = "References";
            nowait = true;
          };
        }
        {
          key = "<leader>lgt";
          action.__raw = ''
            function()
            Snacks.picker.lsp_type_definitions()
            end
          '';
          options = {
            desc = "Type";
          };
        }
        {
          key = "<leader>lwd";
          action.__raw = ''
            function()
            Snacks.picker.diagnostics()
            end
          '';
          options = {
            desc = "Diagnostic";
          };
        }
        {
          key = "<leader>lws";
          action.__raw = ''
            function()
            Snacks.picker.lsp_worspace_symbols()
            end
          '';
          options = {
            desc = "Symbol";
          };
        }
        {
          key = "<leader>ld";
          action.__raw = ''
            function()
                Snacks.picker.diagnostics_buffer()
            end
          '';
          options = {
            desc = "Diagnostic";
          };
        }
        {
          key = "<leader>lS";
          action.__raw = ''
            function()
                Snacks.picker.lsp_symbols()
            end
          '';
          options = {
            desc = "Document Symbol";
          };
        }
      ]
    );
  };

  plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<leader>l";
      group = "LSP";
      icon = "";
    }
    {
      __unkeyed-1 = "<leader>lw";
      group = "Workspace";
      icon = "";
    }
    {
      __unkeyed-1 = "<leader>lg";
      group = "Go to";
      icon = "";
    }
  ];
}
