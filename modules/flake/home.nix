{
  inputs,
  lib,
  config,
  ...
}:
{
  options.configurations.homeManager = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule {
        options.module = lib.mkOption {
          type = lib.types.deferredModule;
        };
      }
    );
  };

  config.flake = {
    homeConfigurations = lib.flip lib.mapAttrs config.configurations.homeManager (
      name:
      let
        host = config.configurations.nixos.${name};
        pkgs = import inputs.nixpkgs {
          inherit (host) system;
          config.allowUnfree = host.allowUnfree;
        };
      in
      { module, ... }:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          config.flake.modules.homeManager.stylix
          (
            { pkgs, ... }:
            {
              stylix.image = host.wallpaper;
              stylix.base16Scheme = lib.mkIf (
                host.base16Scheme != null
              ) "${pkgs.base16-schemes}/share/themes/${host.base16Scheme}.yaml";
            }
          )

          { nixpkgs.config.allowUnfree = host.allowUnfree; }

          module

          {
            home = {
              homeDirectory = lib.mkDefault "/home/${config.user.username}";
              inherit (config.user) username;
              inherit (host) stateVersion;
            };

            programs.home-manager.enable = true;
          }
        ];
      }
    );

    checks =
      config.flake.homeConfigurations
      |> lib.mapAttrsToList (
        name: hmConfig: {
          ${hmConfig.pkgs.stdenv.hostPlatform.system} = {
            "configurations:home:${name}" = hmConfig.activationPackage;
          };
        }
      )
      |> lib.mkMerge;
  };
}
