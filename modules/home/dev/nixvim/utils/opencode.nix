{
  flake.modules.homeManager.nixvim = {
    programs.nixvim = {
      plugins = {
        opencode = {
          enable = true;
        };

        snacks = {
          enable = true;

          settings = {
            terminal.enable = true;
            input.enable = true;
            picker.enable = true;
          };
        };
      };

      extraConfigLua = ''
        local opencode_cmd = "opencode --port"

        local snacks_terminal_opts = {
          win = {
            position = "right",
            enter = false,
          },
        }

        vim.g.opencode_opts = {
          server = {
            start = function()
              require("snacks.terminal").open(
                opencode_cmd,
                snacks_terminal_opts
              )
            end,
          },
        }

        vim.keymap.set({ "n", "t" }, "<C-.>", function()
          require("snacks.terminal").toggle(
            opencode_cmd,
            snacks_terminal_opts
          )
        end, { desc = "Toggle OpenCode" })

        vim.api.nvim_create_autocmd("User", {
          pattern = { "OpencodeEvent:tui.command.execute" },
          callback = function(args)
            local event = args.data.event

            if event.properties.command == "prompt.submit" then
              local win = require("snacks.terminal").get(
                opencode_cmd,
                { create = false }
              )

              if win then
                win:show()
              end
            end
          end,
        })
      '';

      keymaps = [
        {
          mode = [
            "n"
            "x"
          ];
          key = "<C-a>";
          action.__raw = ''function() require("opencode").ask("@this: ", { submit = true }) end'';
          options.desc = "Ask opencode…";
        }
        {
          mode = [
            "n"
            "x"
          ];
          key = "<C-x>";
          action.__raw = ''function() require("opencode").select() end'';
          options.desc = "Execute opencode action…";
        }
        {
          mode = [
            "n"
            "t"
          ];
          key = "<C-.>";
          action.__raw = "function() ToggleOpencode() end";
          options.desc = "Toggle Opencode";
        }
        {
          mode = [
            "n"
            "x"
          ];
          key = "go";
          action.__raw = ''function() return require("opencode").operator("@this ") end'';
          options = {
            desc = "Add range to opencode";
            expr = true;
          };
        }
        {
          mode = "n";
          key = "goo";
          action.__raw = ''function() return require("opencode").operator("@this ") .. "_" end'';
          options = {
            desc = "Add line to opencode";
            expr = true;
          };
        }

        {
          mode = "n";
          key = "<S-C-u>";
          action.__raw = ''function() require("opencode").command("session.half.page.up") end'';
          options.desc = "Scroll opencode up";
        }
        {
          mode = "n";
          key = "<S-C-d>";
          action.__raw = ''function() require("opencode").command("session.half.page.down") end'';
          options.desc = "Scroll opencode down";
        }

        {
          mode = "n";
          key = "+";
          action = "<C-a>";
          options = {
            desc = "Increment under cursor";
            noremap = true;
          };
        }
        {
          mode = "n";
          key = "-";
          action = "<C-x>";
          options = {
            desc = "Decrement under cursor";
            noremap = true;
          };
        }
      ];
    };
  };
}
