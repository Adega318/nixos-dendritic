{
  flake.modules.nixos.proton =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        protonmail-desktop
        protonmail-export
      ];
    };
}
