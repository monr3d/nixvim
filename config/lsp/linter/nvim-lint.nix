_: {
  config = {
    autoGroups.nvim_lint.clear = true;

    plugins.lint = {
      enable = true;
      lazyLoad.settings.event = [
        "DeferredUIEnter"
      ];
      autoCmd = {
        desc = "Run linter(s) for the buffer’s filetype, with config file checks";
        event = [
          "BufReadPost"
          "BufWritePost"
          "InsertLeave"
          "TextChanged"
        ];
        pattern = [
          "*.*"
          ".*"
        ];
        group = "nvim_lint";
        callback.__raw = ''
          function(event)
              local lint = require("lint")
              local current_buf = event.buf -- Get the buffer number from the event

              -- Get the filetype specifically for the current buffer from the event
              local ft = vim.api.nvim_get_option_value("filetype", { buf = current_buf })

              -- 1. Uses lint._resolve_linter_by_ft for robust filetype parsing.
              -- This handles splitting filetypes (e.g., 'python.django' resolves 'python' and 'django')
              local names = lint._resolve_linter_by_ft(ft)

              -- Create a copy of the names table to avoid modifying the original during extension.
              names = vim.list_extend({}, names)

              -- 2. Explicitly adds _ and * linters.
              -- Add fallback linters (for filetypes without specific configurations).
              if #names == 0 then
                  vim.list_extend(names, lint.linters_by_ft["_"] or {})
              end

              -- Add global linters (run on all filetypes).
              vim.list_extend(names, lint.linters_by_ft["*"] or {})

              -- Context for linter conditions (if any linter defines a 'condition' function)
              local ctx = {
                  filename = vim.api.nvim_buf_get_name(current_buf),
                  dirname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(current_buf), ":h"),
                  buf = current_buf,    -- Pass the buffer explicitly to the context
                  filetype = ft,        -- Pass the filetype explicitly to the context
              }

              -- Filter out linters that don't exist or don't match their defined condition.
              names = vim.tbl_filter(function(name)
                  local linter = lint.linters[name]
                  -- 4. vim.notify for missing linters (warns).
                  if not linter then
                      vim.notify("Linter not found: " .. name, vim.log.levels.WARN, { title = "nvim-lint" })
                      return false -- Filter out this non-existent linter
                  end

              -- Handle linters defined as functions (less common, but supported by nvim-lint)
                  if type(linter) == "function" then
                      linter = linter()
                      lint.linters[name] = linter -- Cache the resolved linter table
                  end

                  -- Check linter.condition if it exists and is a function
                  if type(linter) == "table" and linter.condition and not linter.condition(ctx) then
                      return false -- Filter out if condition is not met
                  end

                  -- If you want the `linter.required_files` logic, it should be part of the
                  -- linter's `condition` function or added as an additional filter here.
                  -- For example:
                  -- if linter.required_files then
                  --     local found_required_file = false
                  --     for _, fn in ipairs(linter.required_files) do
                  --         local path = vim.fs.joinpath(linter.cwd or vim.fn.getcwd(), fn);
                  --         if vim.uv.fs_stat(path) then
                  --             found_required_file = true
                  --             break
                  --         end
                  --     end
                  --     if not found_required_file then
                  --         return false
                  --     end
                  -- end

                return true -- Keep this linter if all checks pass
              end, names)

              -- 3. Calls lint.try_lint(names) for potentially optimized batch execution.
              if #names > 0 then
                  lint.try_lint(names, { buf = current_buf }) -- Pass the buffer number to try_lint
              end
          end
        '';
      };
    };
  };
}
