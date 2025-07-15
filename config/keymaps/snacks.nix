{ config, lib, ... }:
{
  config = {
    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>f";
        group = "Find";
        icon = "";
      }
      {
        __unkeyed-1 = "<leader>g";
        group = "Git";
        icon = "";
      }
      {
        __unkeyed = "<leader>e";
        icon = "󱏒";
      }

    ];

    plugins.snacks.lazyLoad.settings.keys =
      lib.optional (!(builtins.elem "explorer" config.ui.snacks.exclude)) {
        __raw = "{ '<leader>e', function() Snacks.explorer() end, desc = 'File Explorer' }";
      }
      ++ lib.optional (!(builtins.elem "picker" config.ui.snacks.exclude)) {
        __raw = ''
          -- find
          { '<leader><leader>', function() Snacks.picker.smart() end, desc = 'Smart Find File'},
          { '<leader>:', function() Snacks.picker.command_history() end, desc = 'Command History' },
          { '<leader>n', function() Snacks.picker.notifications() end, desc = 'Notification History'},
          { '<leader>fb', function() Snacks.picker.buffers() end, desc = 'Existing buffers'},
          { '<leader>ff', function() Snacks.picker.files() end, desc = 'Files in Project Directory' },
          { '<leader>fh', function() Snacks.picker.help() end, desc = 'Help Pages' },
          { '<leader>fk', function() Snacks.picker.keymaps() end, desc = 'Keymaps' },
          -- { '<leader>fl', function() Snacks.picker.lines() end, desc = 'lines' },
          { '<leader>fp', function() Snacks.picker.projects() end, desc = 'Projects' },
          { '<leader>fr', function() Snacks.picker.recent() end, desc = 'Recent' },
          -- grep
          { '<leader>/', function() Snacks.picker.grep_buffers() end, desc = 'Grep in Current Buffer' },
          { '<leader>fg', function() Snacks.picker.grep() end, desc = 'Grep in Project Directory' },
          { '<leader>fw', function() Snacks.picker.lines() end, desc = 'Grep Lines' },
          { '<leader>fw', function() Snacks.picker.grep_word() end, desc = 'Grep Current Word' },
          -- git
          { '<leader>gb', function() Snacks.picker.git_branches() end, desc = 'Git Branches' },
          { '<leader>gf', function() Snacks.picker.git_files() end, desc = 'Git Files' },
          { '<leader>gl', function() Snacks.picker.git_log() end, desc = 'Git Log' },
          { '<leader>gL', function() Snacks.picker.git_log_line() end, desc = 'Git Log Line' },
          { '<leader>gs', function() Snacks.picker.git_status() end, desc = 'Git Status' },
          { '<leader>gS', function() Snacks.picker.git_stash() end, desc = 'Git Stash' },
          { '<leader>gd', function() Snacks.picker.git_diff() end, desc = 'Git Diff (Hunks)' },
          { '<leader>gf', function() Snacks.picker.git_log_file() end, desc = 'Git Log File' }
        '';
      }
      ++ lib.optional (!(builtins.elem "lazygit" config.ui.snacks.exclude)) {
        __raw = "{ '<leader>gg', function() Snacks.lazygit() end, desc = 'LazyGit' }";
      };
  };
}
