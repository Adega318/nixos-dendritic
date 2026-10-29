{
  flake.modules.homeManager.nixvim = {
    programs.nixvim = {
      plugins = {
        bufferline = {
          enable = true;
          settings.options.mode = "buffers";
        };
        scope.enable = true;
      };
      keymaps = [
        {
          mode = "n";
          key = "<S-h>";
          action = "<CMD>BufferLineCyclePrev<CR>";
          options = {
            desc = "Previous Buffer";
          };
        }
        {
          mode = "n";
          key = "<leader>bn";
          action = "<CMD>BufferLineCyclePrev<CR>";
          options = {
            desc = "Previous Buffer";
          };
        }
        {
          mode = "n";
          key = "<S-l>";
          action = "<CMD>BufferLineCycleNext<CR>";
          options = {
            desc = "Next Buffer";
          };
        }
        {
          mode = "n";
          key = "<leader>bb";
          action = "<CMD>e #<CR>";
          options = {
            desc = "Switch to Other Buffer";
          };
        }
        {
          mode = [
            "n"
          ];
          key = "<A-h>";
          action = "<Cmd>BufferLineMovePrev<CR>";
          options = {
            desc = "Move Buffer to the Left";
          };
        }
        {
          mode = [
            "n"
          ];
          key = "<A-l>";
          action = "<Cmd>BufferLineMoveNext<CR>";
          options = {
            desc = "Move Buffer to the Right";
          };
        }
      ];
    };
  };
}
