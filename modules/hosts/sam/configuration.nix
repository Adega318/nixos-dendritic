{ config, ... }:
{
  configurations.nixos.sam = {
    # System options
    stateVersion = "26.05";
    wallpaper = ../../../wallpapers/linux_atari.png;
    base16Scheme = "gruvbox-dark-hard";

    # Modules
    module =
      { ... }:
      {
        imports = with config.flake.modules.nixos; [
          bluetooth
          docker
          plymouth
          podman
          wacom

          # CORE
          core

          # DESKTOP
          desktop
          kde

          # SERVICES
          tailscale
        ];

        config = {
        };
      };
  };
}
