_: {
  config = {
    keymaps = [
      # Clear Hightlight
      {
        action = "<cmd>nohlsearch<CR>";
        key = "<Esc>";
        mode = "n";
        options = {
          desc = "Clear highlights on search";
          silent = true;
        };
      }
      # Move entire lines up/down
      {
        key = "J";
        mode = [ "v" ];
        action = ":m '>+1<CR>gv=gv";
        options.desc = "Move lines down";
      }
      {
        key = "K";
        mode = [ "v" ];
        action = ":m '<-2<CR>gv=gv";
        options.desc = "Move lines up";
      }
      # Increase/decrease indentation
      {
        key = "<";
        mode = [ "v" ];
        action = "<gv";
        options.desc = "Decrease indent";
      }
      {
        key = ">";
        mode = [ "v" ];
        action = ">gv";
        options.desc = "Increase indent";
      }
      # window navigation
      {
        key = "<C-h>";
        action = "<C-w>h";
        options.desc = "Move focus to the left window";
      }
      {
        key = "<C-j>";
        action = "<C-w>j";
        options.desc = "Move focus to the lower window";
      }
      {
        key = "<C-k>";
        action = "<C-w>k";
        options.desc = "Move focus to the upper window";
      }
      {
        key = "<C-l>";
        action = "<C-w>l";
        options.desc = "Move focus to the right window";
      }
      # Move cursor by virtual line (for example in wrapped line)
      # https://blog.petrzemek.net/2016/04/06/things-about-vim-i-wish-i-knew-earlier/
      {
        key = "j";
        action = "v:count == 0 ? \"gj\" : \"j\"";
        options = {
          expr = true;
          noremap = true;
          silent = true;
          desc = "up N lines (or 1 virtual)";
        };
      }
      {
        key = "k";
        action = "v:count == 0 ? \"gk\" : \"k\"";
        options = {
          expr = true;
          noremap = true;
          silent = true;
          desc = "down N lines (or 1 virtual)";
        };
      }
    ];
  };
}
