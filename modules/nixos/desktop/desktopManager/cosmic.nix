{
  flake.modules.nixos.cosmic =
    { pkgs, ... }:
    {
      services = {
        desktopManager.cosmic = {
          enable = true;
          showExcludedPkgsWarning = false;
        };
        flatpak.enable = true;
        system76-scheduler.enable = true;
      };

      environment = {
        cosmic.excludePackages = with pkgs; [
          cosmic-edit
          cosmic-term
        ];
        sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;

        systemPackages = with pkgs; [
          cosmic-ext-tweaks
          cosmic-ext-calculator
          cosmic-applets
          eog
        ];
      };
    };
}
