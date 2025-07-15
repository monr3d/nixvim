{ config, lib, ... }:
{
  imports = [
    (import ./providers/emoji.nix { offset = -10; })
    ./providers/friendly-snippets.nix
    (import ./providers/ripgrep.nix { offset = 10; })
    (import ./providers/spell.nix {
      inherit lib;
      offset = -10;
    })
  ];

  config = {
    plugins = {
      blink-cmp = {
        enable = true;
        lazyLoad.settings.event = [
          "InsertEnter"
          "CmdlineEnter"
        ];
        settings = {
          enabled.__raw = ''
            function()
                return not vim.tbl_contains({ "snacks_dashboard" }, vim.bo.filetype)
                    and vim.bo.buftype ~= "prompt"
                    and vim.b.completion ~= false
            end
          '';
          appearance.use_nvim_cmp_as_default = true;
          completion = {
            documentation = {
              auto_show = true;
            };
            ghost_text = {
              enabled = true;
              show_without_selection = true;
            };
            list.selection = {
              preselect = false;
            };
            menu = {
              draw = {
                columns = [
                  {
                    __unkeyed = "kind_icon";
                  }
                  {
                    __unkeyed_1 = "label";
                    __unkeyed_2 = "label_description";
                    gap = 1;
                  }
                  {
                    __unkeyed = "source_name";
                  }
                ];
                components = lib.mkIf config.plugins.mini-icons.enable {
                  kind_icon = {
                    text.__raw = ''
                      function(ctx)
                          local icon = ctx.kind_icon

                          if vim.tbl_contains({ "Path" }, ctx.source_name) then
                              local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                              if dev_icon then
                                  icon = dev_icon
                              end
                          else
                              local mini_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                              if mini_icon and mini_icon ~= '󰞋' then
                                  icon = mini_icon
                              else
                                  local custom_icon = require('blink.cmp.config').appearance.kind_icons[ctx.kind]
                                  if custom_icon then
                                      icon = custom_icon
                                  end
                              end
                          end
                          return (icon or "") .. (ctx.icon_gap or "")
                      end
                    '';
                    highlight.__raw = ''
                      function(ctx)
                          local hl = ctx.kind_hl

                          if vim.tbl_contains({ "Path" }, ctx.source_name) then
                              local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                              if dev_icon then
                                  hl = dev_hl
                              end
                          else
                              local _, mini_hl, _ = require('mini.icons').get('lsp', ctx.kind)
                              if mini_hl then
                                  hl = mini_hl
                              end
                          end

                          return hl
                      end
                    '';
                  };
                };
              };
            };
          };
          signature.enabled = true;
          sources = {
            default.__raw = ''
              -- https://github.com/khaneliman/khanelivim/blob/main/modules/nixvim/plugins/blink/default.nix
              function(ctx)
                  -- Base sources that are always available
                  local base_sources = { 'buffer', 'lsp', 'path', 'snippets' }

                  -- Build common sources list dynamically based on enabled plugins
                  local common_sources = vim.deepcopy(base_sources)

                  -- Add optional sources based on plugin availability
                  ${lib.optionalString config.plugins.blink-emoji.enable "table.insert(common_sources, 'emoji')"}
                  ${lib.optionalString config.plugins.blink-cmp-spell.enable "table.insert(common_sources, 'spell')"}
                  ${lib.optionalString config.plugins.blink-ripgrep.enable "table.insert(common_sources, 'ripgrep')"}

                  -- Special context handling
                  local success, node = pcall(vim.treesitter.get_node)
                  if success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
                      return { 'buffer', 'spell' }
                  else
                      return common_sources
                  end
              end
            '';
            per_filetype = {
              gitcommit = [
                "buffer"
                "spell"
              ];
            };
            providers = {
              path = {
                opts = {
                  get_cwd.__raw = ''
                    function(_)
                      return vim.fn.getcwd()
                    end
                  '';
                };
              };
            };
          };
        };
      };
    };
  };
}
