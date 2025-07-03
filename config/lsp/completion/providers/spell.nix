{ lib, offset, ... }:
{
  config = {
    opts = {
      spell = true;
      spelllang = lib.mkDefault [ "en_gb" ];
    };

    plugins = {
      blink-cmp-spell.enable = true;
      blink-cmp.settings.sources.providers.spell = {
        name = "Spell";
        module = "blink-cmp-spell";
        score_offset = offset;
      };
    };
  };
}
