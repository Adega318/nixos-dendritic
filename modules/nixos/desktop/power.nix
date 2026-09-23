{
  flake.modules.nixos.power =
    { pkgs, ... }:
    {
      services = {
        power-profiles-daemon.enable = true;

        upower = {
          enable = true;
          percentageLow = 20;
          percentageCritical = 10;
          percentageAction = 5;
          criticalPowerAction = "Hibernate";
        };

        thermald.enable = false;
      };

      powerManagement = {
        enable = true;
        powertop.enable = true;
        powerUpCommands = ''
          ${pkgs.powertop}/bin/powertop --auto-tune
        '';
      };
    };
}
