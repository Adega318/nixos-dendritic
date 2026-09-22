{ config, lib, ... }:
let
  flakeConfig = config;
in
{
  flake.modules.nixos.user = { config, ... }: {
    users.users = {
      root = {
        isSystemUser = true;
        hashedPasswordFile = lib.mkDefault config.sops.secrets."system/rootPassword".path;
      };

      ${flakeConfig.user.username} = {
        isNormalUser = true;
        description = flakeConfig.user.username;
        hashedPasswordFile = lib.mkDefault config.sops.secrets."system/userPassword".path;
      };
    };
  };
}
