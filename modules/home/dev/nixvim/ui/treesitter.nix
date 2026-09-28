{
  flake.modules.homeManager.nixvim = { pkgs, ... }: {
    programs.nixvim = {
      plugins = {
        treesitter = {
          enable = true;
          nixGrammars = true;
          grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
            html
          ];
          settings = {
            highlight.enable = true;
            indent.enable = true;
          };
        };
        treesitter-context = {
          enable = true;
          settings = {
            max_lines = 2;
          };
        };
        rainbow-delimiters.enable = true;
      };

      keymaps = [
        {
          key = "<leader>co";
          action = "<CMD>TSContextToggle<CR>";
          options.desc = "Toggle Treesitter context";
        }
      ];
    };
  };
}
