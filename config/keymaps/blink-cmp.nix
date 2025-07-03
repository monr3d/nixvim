{ config, lib, ... }:
{
  config = lib.mkIf config.plugins.blink-cmp.enable {
    plugins.blink-cmp.settings.keymap = {
      preset = "none";
      "<C-Space>" = [
        "show"
        "fallback"
      ];
      "<C-d>" = [
        "scroll_documentation_up"
        "fallback"
      ];
      "<C-e>" = [
        "hide"
        "fallback"
      ];
      "<C-f>" = [
        "scroll_documentation_down"
        "fallback"
      ];
      "<CR>" = [
        "accept"
        "fallback"
      ];
      "<S-Tab>" = [
        "select_prev"
        "snippet_backward"
        "fallback"
      ];
      "<Tab>" = [
        "select_next"
        "snippet_forward"
        {
          __raw = ''
            function(cmp)
              local line, col = unpack(vim.api.nvim_win_get_cursor(0))
              has_words_before = col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil

              if has_words_before then
                return cmp.show()
              end
            end
          '';
        }
        "fallback"
      ];
    };
  };
}
