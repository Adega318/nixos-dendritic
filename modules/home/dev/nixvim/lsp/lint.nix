{
  flake.modules.homeManager.nixvim = {
    programs.nixvim = {
      plugins.lint = {
        enable = true;
        lintersByFt = {
          go = [ "golangcilint" ];
          nix = [ "statix" ];
        };
      };
      autoCmd = [
        {
          event = [
            "BufWritePost"
            "BufReadPost"
            "InsertLeave"
          ];
          group = "nvim-lint";
          callback = {
            __raw = "function() require('lint').try_lint() end";
          };
        }
      ];
      autoGroups = {
        "nvim-lint" = {
          clear = true;
        };
      };
    };
  };
}
