{ lib, config, ... }:
{
  options.configurations.nixos = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule {
        options = {
          system = lib.mkOption {
            type = lib.types.singleLineStr;
            readOnly = true;
            default = "x86_64-linux";
          };
          stateVersion = lib.mkOption {
            type = lib.types.singleLineStr;
            readOnly = true;
          };
          allowUnfree = lib.mkOption {
            type = lib.types.bool;
            default = true;
          };

          wallpaper = lib.mkOption {
            type = lib.types.path;
          };
          base16Scheme = lib.mkOption {
            type = lib.types.nullOr (
              lib.types.enum [
                "catppuccin-mocha"
                "gruvbox-dark-hard"
                "tokyo-night-dark"
              ]
            );
            default = null;
          };

          module = lib.mkOption {
            type = lib.types.deferredModule;
          };
        };
      }
    );
  };

  config.flake = {
    nixosConfigurations = lib.flip lib.mapAttrs config.configurations.nixos (
      name:
      {
        module,
        system,
        allowUnfree,
        stateVersion,
        wallpaper,
        base16Scheme,
        ...
      }:
      lib.nixosSystem {
        modules = [
          (
            { pkgs, ... }:
            {
              stylix.image = wallpaper;
              stylix.base16Scheme = lib.mkIf (
                base16Scheme != null
              ) "${pkgs.base16-schemes}/share/themes/${base16Scheme}.yaml";
            }
          )

          config.flake.modules.nixos.sops
          config.flake.modules.nixos.stylix

          module

          {
            nixpkgs = {
              hostPlatform = system;
              config.allowUnfree = allowUnfree;
            };

            nix = {
              settings.experimental-features = [
                "pipe-operators"
                "nix-command"
                "flakes"
              ];
              optimise.automatic = true;
              gc = {
                automatic = true;
                dates = "weekly";
                options = "--delete-older-than 30d";
              };
            };

            networking.hostName = name;

            system.stateVersion = stateVersion;
          }
        ];

        specialArgs = {
          hostname = name;
        };
      }
    );

    checks =
      config.flake.nixosConfigurations
      |> lib.mapAttrsToList (
        name: nixos: {
          ${nixos.config.nixpkgs.hostPlatform.system} = {
            "configurations:nixos:${name}" = nixos.config.system.build.toplevel;
          };
        }
      )
      |> lib.mkMerge;
  };
}
