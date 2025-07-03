{ config, lib, ... }:
{
  imports = [
    (import ./providers/emoji.nix { offset = -10; })
    ./providers/friendly-snippets.nix
    (import ./providers/ripgrep.nix { offset = 10; })
    (import ./providers/spell.nix {
      inherit lib;
      offset = -5;
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
                return not vim.tbl_contains({ "dashboard" }, vim.bo.filetype)
                    and vim.bo.buftype ~= "prompt"
                    and vim.b.completion ~= false
            end
          '';
          completion = {
            documentation.auto_show = true;
            ghost_text.enabled = true;
            list.selection = {
              auto_insert = false;
              preselect = false;
            };
            menu.draw.columns = [
              {
                __unkeyed = "kind_icon";
              }
              {
                __unkeyed_2 = "label";
                __unkeyed_3 = "label_description";
                gap = 1;
              }
              {
                __unkeyed_1 = "source_name";
              }
            ];
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
