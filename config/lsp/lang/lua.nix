{ pkgs, ... }:
{
  config = {
    extraPackages = with pkgs; [
      stylua
    ];

    plugins = {
      conform-nvim.settings = {
        formatters.stylua.command = "stylua";
        formatters_by_ft.lua = [ "stylua" ];
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
