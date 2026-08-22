# Flake Infrastructure Modules

This directory contains the underlying logic that powers the flake outputs and configuration management.

## Key Files

- `flake-parts.nix`: Integration point for `flake-parts` modules.
- `nixos.nix`: Defines the `configurations.nixos` option (a lazy attrset of per-host NixOS configs with `system`, `stateVersion`, `allowUnfree`, `wallpaper`, `base16Scheme`, `module`). Reads these options and generates `nixosConfigurations` — each with Stylix theming, Nix settings (GC, experimental-features), networking, and the deferred `module` import.
- `home.nix`: Defines the `configurations.homeManager` option. Generates `homeConfigurations` by pulling `system`, `allowUnfree`, `wallpaper`, and `base16Scheme` from the corresponding NixOS host config.
- `stylix.nix`: Declarative theming (dark polarity, Agave Nerd Font, Bibata-Modern-Ice cursor, Noto Color Emoji). Published as both a NixOS module and a Home Manager module, with Firefox/Librewolf/Zen theme targets.
- `formatter.nix`: Defines the project-wide formatter (`nix fmt` → nixfmt).
- `systems.nix`: Specifies the standard systems supported by this flake (x86_64-linux, aarch64-linux).
- `variables.nix`: Defines shared read-only options (`user.username`, `user.email`, `user.hashedPassword`, `rootHashedPassword`, `stateVersion`).

## Dendritic Pattern

The dendritic pattern allows for automatic recursive discovery of modules. The flake output is bootstrapped by passing `./modules` to `import-tree`, which recursively discovers all `.nix` files and makes them available as flake-parts modules. This logic is also baked into the `home.nix` and `nixos.nix` generators, ensuring that adding a new module file to `modules/home` or `modules/nixos` makes it immediately available for import.

## How it works

1. `import-tree ./modules` reads every `.nix` file under `modules/` and returns them as a flake-parts module
2. `flake-parts` merges all discovered modules, making their `config.flake.*` outputs available
3. `nixos.nix` and `home.nix` iterate over the user-defined `configurations.nixos.*` and `configurations.homeManager.*` options to generate the final NixOS / Home Manager configurations
