{
  flake.modules.homeManager.udiskie = { pkgs, ... }: {
    services.udiskie = {
      enable = true;
      tray = "never";
      # HACK: fix for temp test errors because of upstean change
      package = pkgs.udiskie.overridePythonAttrs (_: {
        doCheck = false;
      });
    };
  };
}
