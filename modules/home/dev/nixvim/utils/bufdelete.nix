{
  flake.modules.homeManager.nixvim = {
    programs.nixvim = {
      plugins.bufdelete.enable = true;
      keymaps = [
        {
          mode = "n";
          key = "<leader>bd";
          action = "<CMD>Bdelete<CR>";
          options = {
            desc = "Delete Buffer";
          };
        }
        {
          mode = "n";
          key = "<leader>bw";
          action = "<CMD>%bdelete<CR>";
          options = {
            desc = "Wipe All Buffers";
          };
        }
        {
          mode = "n";
          key = "<leader>bo";
          action = "<CMD>let cur=bufnr('%') | bufdo if bufnr('%') != cur | bdelete | endif<CR>";
          options = {
            desc = "Delete Other Buffers";
          };
        }
      ];
    };
  };
}
