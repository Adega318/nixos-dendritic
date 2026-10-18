{
  flake.modules.homeManager.nixvim =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.bacon ];

      programs.nixvim = {
        plugins.bacon = {
          enable = true;
          settings.quickfix = {
            enabled = true;
            event_trigger = true;
          };
        };

        keymaps = [
          {
            key = "<leader>rb";
            action = "<CMD>BaconLoad<CR><CMD>w<CR><CMD>BaconNext<CR>";
            options.desc = "Bacon: load and jump to first error";
          }
          {
            key = "<leader>rB";
            action = "<CMD>BaconShow<CR>";
            options.desc = "Bacon: show locations";
          }
        ];
      };
    };
}
