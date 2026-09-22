{
  flake.modules.homeManager.nixvim =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        uv
      ];

      programs.nixvim = {
        plugins = {
          whichpy = {
            enable = true;
            settings = {
              update_path_env = true;
              cache_dir.__raw = "vim.fn.stdpath('cache') .. '/whichpy.nvim'";
              picker.name = "telescope"; # uses existing telescope; fallback to "builtin"
              locator = {
                workspace = {
                  display_name = "Workspace";
                  search_pattern = ".*env.*";
                  depth = 3;
                  ignore_dirs = [
                    ".git"
                    ".mypy_cache"
                    ".pytest_cache"
                    ".ruff_cache"
                    "__pycache__"
                    "__pypackages__"
                  ];
                };
                # Enable uv discovery (uv venv / uv pip)
                uv.enable = true;
              };
              lsp = {
                # basedpyright uses the same handler as pyright
                basedpyright.__raw = "require('whichpy.lsp.handlers.pyright').new()";
              };
            };
          };

          # DAP for Python — uses debugpy. Provides :DapContinue, breakpoints, etc.
          dap = {
            enable = true;
          };
          dap-python = {
            enable = true;
          };
          dap-ui.enable = true;
          dap-virtual-text.enable = true;

          # Optional: test runner UI for pytest/unittest. Disable if you prefer terminal.
          neotest = {
            enable = true;
            adapters.python.enable = true;
          };
        };

        # DAP / Python helper keymaps
        keymaps = [
          {
            key = "<leader>dB";
            action = "<CMD>lua require('dap').toggle_breakpoint()<CR>";
            options.desc = "DAP: Toggle Breakpoint";
          }
          {
            key = "<leader>dc";
            action = "<CMD>lua require('dap').continue()<CR>";
            options.desc = "DAP: Continue/Start";
          }
          {
            key = "<leader>dr";
            action = "<CMD>lua require('dap').repl.open()<CR>";
            options.desc = "DAP: Repl";
          }
          {
            key = "<leader>du";
            action = "<CMD>lua require('dapui').toggle()<CR>";
            options.desc = "DAP UI: Toggle";
          }
          {
            key = "<leader>dp";
            action = "<CMD>WhichPy select<CR>";
            options.desc = "Python: Select Interpreter (whichpy)";
          }
          {
            key = "<leader>db";
            action = "<CMD>Neotest run<CR>";
            options.desc = "Test: Run Nearest (neotest)";
          }
        ];

        autoGroups = {
          "whichpy_python" = {
            clear = true;
          };
        };
      };
    };
}
