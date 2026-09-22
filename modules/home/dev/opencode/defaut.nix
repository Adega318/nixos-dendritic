{
  flake.modules.homeManager.opencode = {
    programs.opencode = {
      enable = true;
      agents = {
        reviewer = ./reviewer.md;
        documenter = ./documenter.md;
      };
    };
  };
}
