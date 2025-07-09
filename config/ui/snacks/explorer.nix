{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf (!builtins.elem "explorer" config.ui.snacks.exclude) {
    dependencies.ripgrep.enable = true;

    extraPackages = with pkgs; [ fd ];

    autoCmd = [
      {
        callback.__raw = ''
          function()
              Snacks.util.set_hl({
                  PickerTree = { link = 'NonText' },
              }, { prefix = 'Snacks' })
          end
        '';
        event = [ "VimEnter" ];
      }
    ];

    plugins.snacks = {
      settings = {
        explorer.enabled = true;
        picker.sources.explorer = {
          on_show.__raw = ''
            -- https://github.com/folke/snacks.nvim/discussions/1306#discussioncomment-12248922
            function(picker)
                local show = false
                local gap = 1
                local clamp_width = function(value)
                    return math.max(20, math.min(100, value))
                end
                --
                local position = picker.resolved_layout.layout.position
                local rel = picker.layout.root
                local update = function(win) ---@param win snacks.win
                    local border = vim.o.columns - win:border_size().left - win:border_size().right
                    win.opts.row = vim.api.nvim_win_get_position(rel.win)[1]
                    win.opts.height = 0.8
                    if position == 'left' then
                        win.opts.col = vim.api.nvim_win_get_width(rel.win) + gap
                        win.opts.width = clamp_width(border - win.opts.col)
                    end
                    if position == 'right' then
                        win.opts.col = -vim.api.nvim_win_get_width(rel.win) - gap
                        win.opts.width = clamp_width(border + win.opts.col)
                    end
                    win:update()
                end
                local preview_win = Snacks.win.new {
                    relative = 'editor',
                    external = false,
                    focusable = false,
                    border = 'rounded',
                    backdrop = false,
                    show = show,
                    bo = {
                        filetype = 'snacks_float_preview',
                        buftype = 'nofile',
                        buflisted = false,
                        swapfile = false,
                        undofile = false,
                    },
                    on_win = function(win)
                        update(win)
                        picker:show_preview()
                    end,
                }
                rel:on('WinLeave', function()
                    vim.schedule(function()
                        if not picker:is_focused() then
                            picker.preview.win:close()
                        end
                    end)
                end)
                rel:on('WinResized', function()
                    update(preview_win)
                end)
                picker.preview.win = preview_win
                picker.main = preview_win.win
            end
          '';
          on_close.__raw = ''
            function(picker)
              picker.preview.win:close()
            end
          '';
          layout = {
            preset = "sidebar";
            preview = false;
            auto_hide = [ "input" ];
            layout.position = "right";
          };
          actions.toggle_preview.__raw = ''
            function(picker)
                picker.preview.win:toggle()
            end
          '';
        };
      };
    };
  };
}
