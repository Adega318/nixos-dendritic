{
  flake.modules.homeManager.nixvim =
    { pkgs, ... }:
    {
      programs.nixvim = {
        extraPackages = with pkgs; [
          fd
        ];

        plugins.telescope = {
          enable = true;
          extensions = {
            fzf-native = {
              enable = true;
              settings = {
                fuzzy = true;
                override_generic_sorter = true;
                override_file_sorter = true;
                case_mode = "smart_case";
              };
            };
            frecency.enable = true;
            undo.enable = true;
            ui-select = {
              enable = true;
              settings.specific_opts.codeactions = true;
            };
          };

          settings = {
            defaults = {
              file_ignore_patterns = [
                "^.git/"
                "%.ipynb"
              ];

              mappings = {
                i = {
                  "<esc>" = {
                    __raw = ''
                      function(...)                                                                                 
                        return require("telescope.actions").close(...)                                              
                      end'';
                  };
                  "<A-j>" = {
                    __raw = "require('telescope.actions').move_selection_next";
                  };
                  "<A-k>" = {
                    __raw = "require('telescope.actions').move_selection_previous";
                  };
                };
              };
            };
            pickers = {
              colorscheme.enable_preview = true;
              find_files.hidden = true;
            };
          };

          keymaps = {
            # Files
            "<leader><space>" = {
              action = "find_files";
              options.desc = "Find project files";
            };
            "<leader>/" = {
              action = "live_grep";
              options.desc = "Grep (root dir)";
            };
            "<leader>ff" = {
              action = "find_files";
              options.desc = "Find project files";
            };
            "<leader>fg" = {
              action = "live_grep";
              options.desc = "Grep";
            };
            "<C-p>" = {
              action = "git_files";
              options = {
                desc = "Telescope Git Files";
              };
            };

            # Git
            "<leader>gc" = {
              action = "git_commits";
              options.desc = "Commits";
            };
            "<leader>gv" = {
              action = "git_status";
              options.desc = "Git status (view)";
            };

            # Search
            "<leader>sa" = {
              action = "autocommands";
              options.desc = "Auto Commands";
            };
            "<leader>sb" = {
              action = "current_buffer_fuzzy_find";
              options.desc = "Buffer";
            };
            "<leader>sc" = {
              action = "command_history";
              options.desc = "Command History";
            };
            "<leader>sC" = {
              action = "commands";
              options.desc = "Commands";
            };
            "<leader>sD" = {
              action = "diagnostics";
              options.desc = "Workspace diagnostics";
            };
            "<leader>sh" = {
              action = "help_tags";
              options.desc = "Help pages";
            };
            "<leader>sH" = {
              action = "highlights";
              options.desc = "Search Highlight Groups";
            };
            "<leader>sk" = {
              action = "keymaps";
              options.desc = "Keymaps";
            };
            "<leader>sM" = {
              action = "man_pages";
              options.desc = "Man pages";
            };
            "<leader>sm" = {
              action = "marks";
              options.desc = "Jump to Mark";
            };
            "<leader>so" = {
              action = "vim_options";
              options.desc = "Options";
            };
            "<leader>sr" = {
              action = "resume";
              options.desc = "Resume";
            };
            "<leader>sd" = {
              action = "diagnostics";
              options.desc = "Document Diagnostics";
            };
            "<leader>st" = {
              action = "todo-comments";
              options.desc = "Todo (Telescope)";
            };
            "<leader>su" = {
              action = "undo";
              options.desc = "Undo tree";
            };
          };
        };
      };
    };
}
