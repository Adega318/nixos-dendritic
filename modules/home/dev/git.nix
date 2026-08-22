{ config, ... }:
{
  flake.modules.homeManager.git = {
    programs = {
      git = {
        enable = true;
        lfs.enable = true;
        settings = {
          user = {
            name = config.user.username;
            inherit (config.user) email;
          };
          init.defaultBranch = "main";
        };
      };
      lazygit.enable = true;
    };
  };
}
