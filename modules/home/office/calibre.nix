{
  flake.modules.homeManager.calibre =
    { pkgs, ... }:
    {
      programs.calibre = {
        enable = true;
        # HACK: temp disable because of update error
        # package = pkgs.calibre.override { unrarSupport = true; };
      };
    };
}
