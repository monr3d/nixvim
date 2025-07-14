_: {
  config = {
    userCommands.Format = {
      desc = "Format the current buffer or a range of lines";
      range = true;
      command.__raw = ''
        function(args)
            local range = nil
            if args.count ~= -1 then
                local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                range = {
                    start = { args.line1, 0 },
                    ["end"] = { args.line2, end_line:len() },
                }
            end
            require("conform").format({ async = true, lsp_format = "fallback", range = range })
        end
      '';
    };

    plugins.conform-nvim = {
      enable = true;
      lazyLoad = {
        enable = true;
        settings.cmd = [
          "ConformInfo"
        ];
      };
      luaConfig.pre = ''
        local slow_format_filetypes = {}
      '';
      settings = {
        default_format_opts = {
          lsp_format = "fallback";
        };
        format_after_save.__raw = ''
          function(bufnr)
              if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                  return
              end

              if not slow_format_filetypes[vim.bo[bufnr].filetype] then
                  return
              end

              return { lsp_fallback = true }
          end
        '';
        format_on_save.__raw = ''
          function(bufnr)
              -- Disable with a global or buffer-local variable
              -- Toggles for those are in snacks.lua
              if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                  return
              end

              if slow_format_filetypes[vim.bo[bufnr].filetype] then
                  return
              end

              local function on_format(err)
                  if err and err:match('timeout$') then
                      slow_format_filetypes[vim.bo[bufnr].filetype] = true
                  end
              end

              return { timeout_ms = 500, lsp_format = 'fallback', async = false }, on_format
          end
        '';
        formatters.injected.options.ignore_errors = true;
        formatters_by_ft = {
          "_" = [ "trim_whitespace" ];
          "*" = [ "injected" ];
        };
      };
    };
  };
}
