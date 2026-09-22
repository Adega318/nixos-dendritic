{ config, ... }:
{
  flake.modules.homeManager.git = { pkgs, ... }: {
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

    home.packages = with pkgs; [
      gh # github cli
    ];
  };
}
