{
  flake.modules.homeManager.nixvim = {
    programs.nixvim = {
      plugins.toggleterm = {
        enable = true;
        settings = {
          open_mapping = "[[<C-t>]]";
        };
      };

      autoCmd = [
        {
          event = "TermOpen";
          command = "setlocal nospell";
          group = "toggleterm";
        }
      ];
      autoGroups.toggleterm.clear = true;

      keymaps = [
        {
          # Escape terminal mode using ESC
          mode = "t";
          key = "<esc>";
          action = "<C-\\><C-n>";
          options.desc = "Escape terminal mode";
        }
      ];
    };
  };
}
