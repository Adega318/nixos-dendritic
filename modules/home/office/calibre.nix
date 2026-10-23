{
  flake.modules.homeManager.calibre =
    { pkgs, ... }:
    {
      # HACK: pyopenjtalk-plus test fails on error message wording (Python 3.14)
      nixpkgs.overlays = [
        (final: prev: {
          pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
            (pyFinal: pyPrev: {
              pyopenjtalk-plus = pyPrev.pyopenjtalk-plus.overridePythonAttrs (old: {
                disabledTests = (old.disabledTests or [ ]) ++ [
                  "test_run_njd_from_mecab_invalid_input_should_not_break_next_call"
                ];
              });
            })
          ];
        })
      ];

      programs.calibre = {
        enable = true;
        # HACK: calibre's test_speech_dispatcher can't import speechd
        package = pkgs.calibre.overrideAttrs (old: {
          doCheck = false;
          doInstallCheck = false;
        });
      };
    };
}
