{ pkgs, ... }:
{
  config = {
    extraPackages = with pkgs; [
      luajitPackages.luacheck
      stylua
    ];

    plugins = {
      conform-nvim.settings = {
        formatters.stylua.command = "stylua";
        formatters_by_ft.lua = [ "stylua" ];
      };

      lint = {
        linters.luacheck.cmd = "luacheck";
        lintersByFt.lua = [ "luacheck" ];
      };
    };

    lsp.servers.lua_ls = {
      enable = true;
      settings.Lua = {
        workspace.checkThirdParty = false;
        codeLens.enable = true;
        completion.callSnippet = "Replace";
        doc.privateName = [ "^_" ];
        hint.enable = true;
      };
    };
  };
}
