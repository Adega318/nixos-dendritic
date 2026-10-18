{
  flake.modules.homeManager.nixvim = {
    programs.nixvim = {
      plugins.crates = {
        enable = true;
        settings = {
          lsp = {
            enabled = true;
            actions = true;
            completion = true;
            hover = true;
          };
          completion.crates = {
            enabled = true;
            max_results = 8;
            min_chars = 3;
          };
        };
      };
    };
  };
}
