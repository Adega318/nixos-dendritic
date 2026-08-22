{
  flake.modules.homeManager.bottles =
    { pkgs, ... }:
    {
      # HACK: disable check of python.patoolt to enable bottles compilation
      nixpkgs.overlays = [
        (final: prev: {
          python314Packages = prev.python314Packages.overrideScope (
            pyFinal: pyPrev: {
              patool = pyPrev.patool.overridePythonAttrs (_: {
                doCheck = false;
              });
            }
          );
        })
      ];

      home.packages = with pkgs; [
        (bottles.override { removeWarningPopup = true; })
      ];
    };
}
