_: {
  config = {
    lsp = {
      servers = {
        lua_ls = {
          enable = true;
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false;
              };
              codeLens = {
                enable = true;
              };
              completion = {
                callSnippet = "Replace";
              };
              doc = {
                privateName = [ "^_" ];
              };
              hint = {
                enable = true;
              };
            };
          };
        };
      };
    };
  };
}
