{
  flake.modules.nixos.tuta =
    { pkgs, ... }:
    {
      # TODO: fix
      environment.systemPackages = with pkgs; [
        tutanota-desktop
      ];
    };
}
