# Highlight when yanking (copying) text
# Try it with `yap` in normal mode
# See `:help vim.highlight.on_yank()`
_: {
  config = {
    autoCmd = [
      {
        event = "TextYankPost";
        group = "highlight_yank";
        command = "silent! lua vim.hl.on_yank{higroup='Search', timeout=300}";
        desc = "Highlight when yanking (copying) text";
      }
    ];
    autoGroups.highlight_yank.clear = true;
  };
}
