{ inputs, ... }:
{
  flake.modules.nixos.recuncho = {
    imports = [ inputs.recuncho.nixosModules.default ];
    services = {
      recuncho = {
        enable = true;
      };
    };
  };
}
