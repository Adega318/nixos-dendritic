{
  flake.modules.homeManager.opencode = {
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
