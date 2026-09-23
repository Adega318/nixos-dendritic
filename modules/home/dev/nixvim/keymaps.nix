{
  flake.modules.homeManager.nixvim = {
    programs.nixvim = {
      globals.mapleader = " ";
      keymaps = [
        # --- Window Navigation ---
        {
          mode = [
            "n"
            "t"
          ];
          key = "<C-h>";
          action = "<C-w>h";
          options = {
            silent = true;
            desc = "Move to left window";
          };
        }
        {
          mode = [
            "n"
            "t"
          ];
          key = "<C-j>";
          action = "<C-w>j";
          options = {
            silent = true;
            desc = "Move to lower window";
          };
        }
        {
          mode = [
            "n"
            "t"
          ];
          key = "<C-k>";
          action = "<C-w>k";
          options = {
            silent = true;
            desc = "Move to upper window";
          };
        }
        {
          mode = [
            "n"
            "t"
          ];
          key = "<C-l>";
          action = "<C-w>l";
          options = {
            silent = true;
            desc = "Move to right window";
          };
        }

        # --- Window Re sizing ---
        {
          mode = "n";
          key = "<C-Up>";
          action = "<CMD>resize +2<CR>";
          options = {
            desc = "Resize window up";
          };
        }
        {
          mode = "n";
          key = "<C-Down>";
          action = "<CMD>resize -2<CR>";
          options = {
            desc = "Resize window down";
          };
        }
        {
          mode = "n";
          key = "<C-Left>";
          action = "<CMD>vertical resize -2<CR>";
          options = {
            desc = "Resize window left";
          };
        }
        {
          mode = "n";
          key = "<C-Right>";
          action = "<CMD>vertical resize +2<CR>";
          options = {
            desc = "Resize window right";
          };
        }

        # --- Tab Navigation ---
        {
          mode = "n";
          key = "<leader>tn";
          action = "<CMD>tabnew<CR>";
          options.desc = "Create new tab";
        }
        {
          mode = "n";
          key = "<leader>td";
          action = "<CMD>tabclose<CR>";
          options.desc = "Close tab";
        }
        {
          mode = "n";
          key = "<leader>tl";
          action = "<CMD>tabnext<CR>";
          options.desc = "Next tab";
        }
        {
          mode = "n";
          key = "<leader>th";
          action = "<CMD>tabprevious<CR>";
          options.desc = "Previous tab";
        }

        # --- Centered Scrolling & Searching ---
        {
          mode = "n";
          key = "<C-d>";
          action = "<C-d>zz";
          options.desc = "Scroll down & center";
        }
        {
          mode = "n";
          key = "<C-u>";
          action = "<C-u>zz";
          options.desc = "Scroll up & center";
        }
        {
          mode = "n";
          key = "n";
          action = "nzzzv";
          options.desc = "Next search result & center";
        }
        {
          mode = "n";
          key = "N";
          action = "Nzzzv";
          options.desc = "Prev search result & center";
        }

        # --- Visual Line Moving ---
        {
          mode = "v";
          key = "J";
          action = ":m '>+1<CR>gv=gv";
          options.desc = "Move block down";
        }
        {
          mode = "v";
          key = "K";
          action = ":m '<-2<CR>gv=gv";
          options.desc = "Move block up";
        }

        # --- Quality of Life ---
        {
          mode = "n";
          key = "<esc>";
          action = "<CMD>nohlsearch<CR><esc>";
          options.desc = "Escape and clear hlsearch";
        }
        {
          mode = "n";
          key = "<C-s>";
          action = "<CMD>w<CR>";
          options.desc = "Save current file";
        }
        {
          mode = "n";
          key = "<leader>q";
          action = "<CMD>q<CR>";
          options.desc = "Quit";
        }
        {
          mode = "n";
          key = "<leader>Q";
          action = "<CMD>qa<CR>";
          options.desc = "Quit All";
        }
        {
          mode = "n";
          key = "<F7>";
          action = "<CMD>set spell!<CR>";
          options.desc = "Toggle spell checking";
        }
      ];
    };
  };
}
