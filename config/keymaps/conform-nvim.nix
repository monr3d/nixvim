{ config, lib, ... }:
{
  config = lib.mkIf config.plugins.conform-nvim.enable {
    keymapsOnEvents.LspAttach = [
      {
        action = "<cmd>Format<CR>";
        key = "<leader>lf";
        options = {
          desc = "format";
        };
      }
    ];
  };
}
