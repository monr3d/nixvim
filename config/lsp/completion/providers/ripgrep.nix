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
        opts = {
          transform_items.__raw = ''
            function(_, items)
              for _, item in ipairs(items) do
                -- append a description to easily distinguish rg results
                item.labelDetails = {
                  description = "(rg)",
                }
              end
              return items
            end
          '';
        };
      };
    };
  };
}
