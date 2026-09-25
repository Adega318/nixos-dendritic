{
  flake.modules.nixos.sddm =
    {
      pkgs,
      config,
      ...
    }:
    let
      custom-sddm = pkgs.sddm-astronaut.override {
        themeConfig = {
          Background = "${config.stylix.image}";
          Font = config.stylix.fonts.serif.name;
        };
      };
    in
    {
      services = {
        displayManager.sddm = {
          enable = true;
          wayland.enable = true;
          autoNumlock = true;
          theme = "sddm-astronaut-theme";
          extraPackages = [ custom-sddm ];
        };
      };
    };
}
