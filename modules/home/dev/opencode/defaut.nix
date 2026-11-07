{
  flake.modules.homeManager.opencode = {
    # TODO: remove once nixos-unstable contains c399e1b7 ("opencode: fix hash")
    nixpkgs.overlays = [
      (final: prev: {
        opencode = prev.opencode.overrideAttrs (old: {
          node_modules = old.node_modules.overrideAttrs (_: {
            outputHash = "sha256-prx9dX7kUvs/E3zopkaPk5LXh3xJAy5sZeum/W8L7cA=";
          });
        });
      })
    ];

    programs.opencode = {
      enable = true;

      cli = {
        theme = {
          name = "system";
          mode = "system";
        };
        plugins = [
          "oh-my-opencode-slim"
          "context7"
          "@plannotator/opencode"
        ];
      };

      agents = {
        reviewer = ./reviewer.md;
        documenter = ./documenter.md;
      };
    };
  };
}
