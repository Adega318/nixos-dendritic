{
  flake.modules.nixos.noctalia = {
    programs = {
      niri = {
        enable = true;
        useNautilus = true;
      };
      noctalia = {
        enable = true;
        recommendedServices.enable = true;
        systemd.enable = true;
      };
    };
  };
}
