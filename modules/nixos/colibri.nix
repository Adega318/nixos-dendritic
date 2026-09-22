{ inputs, ... }: {
  flake.modules.nixos.colibri = { pkgs, ... }: {
    environment.systemPackages = [
      (inputs.colibri.packages.${pkgs.system}.default.overrideAttrs (old: {
        postInstall = (old.postInstall or "") + ''
          # Upstream c/Makefile:1939 misses v41_dsml.py (openai_server.py:24 imports it)
          # and flake.nix only backfills v4_dsml.py; backfill here until upstream fixes.
          if [ ! -e "$out/lib/colibri/v41_dsml.py" ]; then
            install -m 644 ${inputs.colibri}/c/v41_dsml.py "$out/lib/colibri/"
          fi
        '';
      }))
    ];
  };
}
