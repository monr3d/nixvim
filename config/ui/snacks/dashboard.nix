{ config, lib, ... }:
{
  config = lib.mkIf (!(builtins.elem "dashboard" config.ui.snacks.exclude)) {
    # Workaround until this is merged: https://github.com/folke/snacks.nvim/pull/1643
    autoCmd = [
      {
        callback.__raw = ''
          function()
              vim.o.winborder = 'none'

              vim.defer_fn(function()
                  Snacks.dashboard.update()
              end, 100)

              vim.defer_fn(function()
                  vim.o.winborder = 'rounded'
              end, 100)

          end
        '';
        event = [
          "FileType"
        ];
        once = true;
        group = "DashboardBorder";
        pattern = [
          "snacks_dashboard"
        ];
      }
    ];
    autoGroups = {
      DashboardBorder = {
        clear = true;
      };
    };

    plugins.snacks = {
      settings = {
        dashboard = {
          enabled = true;
          pane_gap = 0;
          preset = {
            header = lib.concatStringsSep "\n" [
              "                                                                   "
              "      ████ ██████           █████      ██         with NixVim"
              "     ███████████             █████                            "
              "     █████████ ███████████████████ ███   ███████████  "
              "    █████████  ███    █████████████ █████ ██████████████  "
              "   █████████ ██████████ █████████ █████ █████ ████ █████  "
              " ███████████ ███    ███ █████████ █████ █████ ████ █████ "
              "██████  █████████████████████ ████ █████ █████ ████ ██████"
            ];
            keys = [
              {
                icon = "   ";
                key = "f";
                desc = "Find File";
                action = ":lua Snacks.dashboard.pick('files')";
              }
              {
                icon = "   ";
                key = "n";
                desc = "New File";
                action = ":ene | startinsert";
              }
              {
                icon = "   ";
                key = "g";
                desc = "Find Text";
                action = ":lua Snacks.dashboard.pick('live_grep')";
              }
              {
                icon = "   ";
                key = "r";
                desc = "Recent Files";
                action = ":lua Snacks.dashboard.pick('oldfiles')";
              }
              {
                icon = "   ";
                key = "c";
                desc = "Show Config";
                # action = ":terminal nixvim-print-init";
                action.__raw = ''
                  function()
                      Snacks.win({
                          text = function()
                              local handle = io.popen("nixvim-print-init")
                              local output
                              if handle then
                                  output = handle:read("*a")
                                  handle:close()
                              else
                                  output = "Error: Could not execute 'nixvim-print-init' command."
                              end
                              return output
                          end,
                          fixbuf = true,
                          position = "float",
                          border = "rounded",
                          resize = true,
                          -- title = {"Nixvim init.lua", "center" },
                          ft = "lua",
                          bo = {
                              filetype = "lua",
                          },
                          wo = {
                              number = true,
                              relativenumber = true,
                          },
                          width = 0.8,
                          height = 0.8,
                          on_win = function(win_obj)
                              -- Use the built-in win:set_title method to center the title
                              win_obj:set_title("nixvim-print-init Output", "center")
                          end,
                      })
                  end
                '';
              }
              {
                icon = "   ";
                key = "s";
                desc = "Restore Session";
                section = "session";
              }
              {
                icon = "   ";
                key = "q";
                desc = "Quit";
                action = ":qa";
              }
            ];
          };
          formats = {
            key.__raw = ''
              function(item)
                  return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]  ", hl = "special" } }
              end
            '';
          };
          sections = [
            {
              section = "header";
              enabled.__raw = ''
                function()
                    local width = vim.o.columns

                    return width < 120
                end
              '';
            }
            {
              text = [
                {
                  __unkeyed = ''

                          ████ ██████           █
                         ███████████             
                         █████████ ███████████
                        █████████  ███    █████
                       █████████ ██████████ █
                     ███████████ ███    ███ █
                    ██████  ███████████████████
                  '';
                  hl = "SnacksDashboardHeader";
                }
              ];
              align = "right";
              enabled.__raw = ''
                function()
                    local width = vim.o.columns

                    return width >= 120
                end
              '';
              padding = 0;
            }
            {
              section = "keys";
              gap = 1;
              padding = 1;
            }
            {
              pane = 2;
              text = [
                {
                  __unkeyed = ''
                               
                    ████      ██         with NixVim
                    █████ 
                    ████████ ███   ███████████
                    ████████ █████ ██████████████
                    ████████ █████ █████ ████ █████
                    ████████ █████ █████ ████ █████
                    ██ ████ █████ █████ ████ ██████
                  '';
                  hl = "SnacksDashboardHeader";
                }
              ];
              align = "left";
              enabled.__raw = ''
                function()
                    local width = vim.o.columns

                    return width >= 120
                end
              '';

            }
            {
              pane = 2;
              icon = "   ";
              title = "Recent Files";
              section = "recent_files";
              cwd = true;
              indent = 5;
              padding = 1;
            }
            {
              pane = 2;
              icon = "   ";
              title = "Projects";
              section = "projects";
              indent = 5;
              padding = 1;
            }
            {
              pane = 2;
              icon = "   ";
              title = "Git Status";
              section = "terminal";
              enabled.__raw = ''
                function()
                  return Snacks.git.get_root() ~= nil
                end
              '';
              cmd = "git status --short --branch --renames";
              height = 5;
              padding = 1;
              ttl = 5 * 60;
              indent = 5;
            }
          ];
        };
      };
    };
  };
}
