{
  flake.modules.nixos.gnome =
    { pkgs, ... }:
    {
      services = {
        desktopManager.gnome.enable = true;
      };
      programs.dconf.enable = true;

      environment.systemPackages = with pkgs; [
        gnome-tweaks
        gnome-extension-manager
      ];
    };
}
