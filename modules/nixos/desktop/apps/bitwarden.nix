{
  flake.modules.nixos.bitwarden =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        bitwarden-desktop
        bitwarden-cli
      ];
    };
}
