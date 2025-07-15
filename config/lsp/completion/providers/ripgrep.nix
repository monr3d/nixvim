{ offset, ... }:
{
  config = {
    dependencies.ripgrep.enable = true;
    plugins = {
      blink-ripgrep.enable = true;
      blink-cmp.settings.sources.providers.ripgrep = {
        async = true;
        module = "blink-ripgrep";
        name = "Ripgrep";
        score_offset = offset;
      };
    };
  };
}
