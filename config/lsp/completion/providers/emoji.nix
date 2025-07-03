{ offset, ... }:
{
  config = {
    plugins = {
      blink-emoji.enable = true;
      blink-cmp.settings.sources.providers.emoji = {
        module = "blink-emoji";
        name = "Emoji";
        score_offset = offset;
        opts = {
          insert = true;
        };
        should_show_items.__raw = ''
          function()
            return vim.tbl_contains(
              -- Enable emoji completion only for git commits and markdown.
              -- By default, enabled for all file-types.
              { "gitcommit", "markdown" },
              vim.o.filetype
            )
          end
        '';
      };
    };
  };
}
