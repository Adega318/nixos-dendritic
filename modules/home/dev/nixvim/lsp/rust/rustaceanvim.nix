{
  flake.modules.homeManager.nixvim = { pkgs, ... }: {
    programs.nixvim.plugins.rustaceanvim = {
      enable = true;
      settings = {
        tools.enable_clippy = true;

        server = {
          default_settings = {
            inlayHints = {
              lifetimeElisionHints = {
                enable = "always";
              };
            };
            rust-analyzer = {
              cargo = {
                allFeatures = true;
              };
              check = {
                command = "clippy";
              };
              files = {
                excludeDirs = [
                  "target"
                  ".git"
                  ".cargo"
                  ".github"
                  ".direnv"
                ];
              };
            };
          };
        };
      };
    };

    home.packages = with pkgs; [
      clippy
    ];
  };
}
