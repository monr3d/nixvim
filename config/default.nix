{ config, lib, ... }:
{
  # Import all your configuration modules here
  imports = [
    ./keymaps
    ./ui/theme.nix
  ];

  config = {
    # Enable the Lua loader
    luaLoader.enable = true;

    # Create 'vi' and 'vim' alias for 'nvim'
    viAlias = true;
    vimAlias = true;

    globals = {
      # Set <space> as the leader key
      # See `:help mapleader`
      mapleader = " ";
      maplocalleader = " ";

      # Set to true if you have a Nerd Font installed and selected in the terminal
      have_nerd_font = true;
    };

    globalOpts = {
      # Minimal number of screen lines to keep above and below the cursor.
      scrolloff = 8;

      # Don't show the mode, since it's already in the status line, we use a plugin for that.
      showmode = false;
      # Set the command line height to 0
      cmdheight = 0;

      # Case-insensitive searching UNLESS \C or one or more capital letters in the search term
      ignorecase = true;
      smartcase = true;
      # Preview substitutions live, as you type!
      inccommand = "split";

      # Enable mouse movement event
      mousemoveevent = true;
      # Enable mouse mode, can be useful for resizing splits for example!
      mouse = "a";

      # Decrease mapped sequence wait time
      timeoutlen = 300;

      # Set the time interval for writing swap files
      updatetime = 250;

      # Configure how new splits should be opened
      # New vertical splits are opened to the right
      splitright = true;
      # New horizontal splits are opened below
      splitbelow = true;

      # if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
      # instead raise a dialog asking if you wish to save the current file(s)
      # See `:help 'confirm'`
      confirm = true;

      # Show matching bracket
      showmatch = true;

      # Configure how completion menu behaves (only if blink-cmp is not enabled)
      completeopt = lib.mkIf (!config.plugins.blink-cmp.enable) [
        "fuzzy"
        "menuone"
        "noselect"
        "popup"
      ];
    };

    opts = {
      # Make line numbers default
      number = true;
      # Relative line numbers, to help with jumping.
      relativenumber = true;

      # Disable swap file
      swapfile = false;
      # Save undo history to an undo file when writing a buffer to a file
      undofile = true;

      # Convert tabs to spaces
      expandtab = true;
      # How many spaces are shown per Tab
      tabstop = 4;
      # Amount to indent with << and >>
      shiftwidth = 4;
      # How many spaces are applied when pressing Tab
      softtabstop = 4;
      # Enable break indent
      breakindent = true;
      # Do smart autoindenting when starting a new line
      smartindent = true;
      # Copy whatever characters were used for indenting on the existing line
      copyindent = true;

      # Sets how neovim will display certain whitespace characters in the editor.
      #  See `:help 'list'`
      #  and `:help 'listchars'`
      list = true;
      listchars = "tab:» ,trail:·,nbsp:␣";

      # Show which line your cursor is on
      cursorline = true;
      # screen columns that are highlighted
      colorcolumn = "80";
      # display signs in the 'number' column
      signcolumn = "number";
    };

    # Clipboard Integration
    clipboard = {
      register = "unnamedplus";
    };

    # Plugin Management
    # Enable the 'lz-n' plugin
    plugins.lz-n.enable = true;

    # Performance Optimizations
    performance = {
      byteCompileLua = {
        enable = true;
        configs = true;
        initLua = true;
        luaLib = true;
        nvimRuntime = true;
        plugins = true;
      };
    };
  };
}
