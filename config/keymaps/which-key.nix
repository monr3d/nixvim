_: {
  config = {
    plugins.which-key = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
      settings = {
        preset = "helix";
        spec = [
          {
            __unkeyed-1 = "<leader>?";
            __unkeyed-2 = "<cmd>lua require('which-key').show({ global = false })<CR>";
            desc = "Buffer Local Keymaps (which-key)";
            mode = "n";
          }
        ];
      };
    };
  };
}
