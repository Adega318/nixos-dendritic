{
  flake.modules.nixos.noctalia =
    { config, lib, ... }:
    {
      options.noctalia.compositor = lib.mkOption {
        type = lib.types.enum [
          "umbriel"
          "niri"
        ];
        default = "niri";
        description = "The Wayland compositor to use with Noctalia.";
      };

      config = {
        programs = {
          umbriel.enable = config.noctalia.compositor == "umbriel";

          niri = {
            enable = config.noctalia.compositor == "niri";
            useNautilus = true;
          };

          noctalia = {
            enable = true;
            recommendedServices.enable = true;
            systemd.enable = true;
          };
        };
      };
    };
}
