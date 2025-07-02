{ config, lib, ... }:
{
  lsp = {
    keymaps = lib.flatten (
      [
        {
          key = "<leader>lf";
          lspBufAction = "format";
          options = {
            desc = "[L]SP: [f]ormat ";
          };
        }
        {
          action.__raw = ''
            function()
              vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end
          '';
          key = "<leader>lwl";
          options = {
            desc = "[w]orkspace: [l]ist Folders";
          };
        }
      ]
      ++ lib.optional (builtins.elem "picker" config.ui.snacks.exclude) [
        {
          key = "<leader>lgn";
          action = "<CMD>lua vim.diagnostic.goto_next()<CR>";
          options = {
            desc = "[G]o to: [n]ext Diagnostic";
          };
        }
        {
          key = "<leader>lgp";
          action = "<CMD>lua vim.diagnostic.goto_prev()<CR>";
          options = {
            desc = "[G]o to: [p]revious Diagnostic";
          };
        }
        {
          key = "<leader>le";
          action = "<CMD>lua vim.diagnostic.open_float()<CR>";
          options = {
            desc = "Go to: [e] Open Diagnostic (float)";
          };
        }
        {
          key = "<leader>lgD";
          lspBufAction = "declaration";
          options = {
            desc = "[G]o to: [D]eclaration";
          };
        }
        {
          key = "<leader>lgd";
          lspBufAction = "definition";
          options = {
            desc = "[G]o to: [d]efinition";
          };
        }
        {
          key = "<leader>lgt";
          lspBufAction = "type_definition";
          options = {
            desc = "[G]o to: [t]ype";
          };
        }
        {
          key = "<leader>lgi";
          lspBufAction = "implementation";
          options = {
            desc = "[G]o to: [i]mplementation";
          };
        }
        {
          key = "<leader>lgr";
          lspBufAction = "references";
          options = {
            desc = "[G]o to: [r]eferences";
            nowait = true;
          };
        }
        {
          key = "<leader>lH";
          lspBufAction = "document_highlight";
          options = {
            desc = "[L]SP: Document [H]ighlight";
          };
        }
        {
          key = "<leader>lS";
          lspBufAction = "document_symbol";
          options = {
            desc = "[L]SP: Document [S]ymbol";
          };
        }
        {
          key = "<leader>lwa";
          lspBufAction = "add_workspace_folder";
          options = {
            desc = "[W]orkspace: [a]dd Folder";
          };
        }
        {
          key = "<leader>lwr";
          lspBufAction = "remove_workspace_folder";
          options = {
            desc = "[W]orkspace: [r]emove Folder";
          };
        }
        {
          key = "<leader>lws";
          lspBufAction = "workspace_symbol";
          options = {
            desc = "[W]orkspace: [s]ymbol";
          };
        }
        {
          key = "<leader>lh";
          lspBufAction = "hover";
          options = {
            desc = "[L]SP: [h]over";
          };
        }
        {
          key = "<leader>ls";
          lspBufAction = "signature_help";
          options = {
            desc = "[L]SP: [s]ignature Help";
          };
        }
        {
          key = "<leader>lr";
          lspBufAction = "rename";
          options = {
            desc = "[L]SP: [r]ename";
          };
        }
        {
          key = "<leader>la";
          lspBufAction = "code_action";
          options = {
            desc = "[L]SP: Code [a]ction";
          };
        }
      ]
    );
  };

  plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<leader>l";
      group = "[l]SP";
      icon = " ";
    }
    {
      __unkeyed-1 = "<leader>lw";
      group = "[w]orkspace";
      # icon = "󰓩 ";
    }
    {
      __unkeyed-1 = "<leader>lg";
      group = "[g]o to";
      icon = " ";
    }
      ];
}
