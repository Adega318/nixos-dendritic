{ config, ... }:
let
  flakeConfig = config;
in
{
  flake.modules.homeManager.anki = { config, pkgs, ... }: {
    programs.anki = {
      enable = true;

      addons = with pkgs.ankiAddons; [ review-heatmap ];

      spacebarRatesCard = true;

      profiles.${flakeConfig.user.username} = {
        default = true;

        sync = {
          usernameFile = config.sops.secrets."anki/username".path;
          keyFile = config.sops.secrets."anki/password".path;

          autoSync = true;
          syncMedia = true;
        };
      };
    };

    stylix.targets.anki.enable = false;
  };
}
