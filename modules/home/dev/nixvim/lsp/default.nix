{
  flake.modules.homeManager.nixvim = { hostname, ... }: {
    programs.nixvim = {
      plugins = {
        lsp = {
          enable = true;
          inlayHints = true;
          servers = {
            # Bash
            bashls.enable = true;
            # C
            clangd.enable = true;
            # Golang
            gopls.enable = true;
            # Nix
            nixd = {
              enable = true;
              settings =
                let
                  flake = "(builtins.getFlake (builtins.toString ./.))";
                in
                {
                  nixpkgs = {
                    expr = "import ${flake}.inputs.nixpkgs { }";
                  };
                  options = {
                    nixos.expr = "${flake}.nixosConfigurations.${hostname}.options";
                    home-manager.expr = "${flake}.homeConfigurations.${hostname}.options";
                  };
                };
            };
            statix.enable = true;
            # Lua
            lua_ls.enable = true;
            # Python
            basedpyright = {
              enable = true;
              settings = {
                basedpyright.analysis = {
                  typeCheckingMode = "standard";
                  diagnosticMode = "workspace";
                  autoImportCompletions = true;
                  autoSearchPaths = true;
                  useLibraryCodeForTypes = true;
                  inlayHints = {
                    callArgumentNames = true;
                    genericTypes = true;
                  };
                };
              };
            };
            ruff = {
              enable = true;
              settings.organizeImports = true;
            };
            # Toml
            taplo.enable = true;
            # Yaml
            yamlls.enable = true;
            # SQL
            sqls.enable = true;
            # Markdown
            marksman.enable = true;
          };
          keymaps = {
            silent = true;
            lspBuf = {
              gd = {
                action = "definition";
                desc = "Goto Definition";
              };
              gr = {
                action = "references";
                desc = "Goto References";
              };
              gD = {
                action = "declaration";
                desc = "Goto Declaration";
              };
              gI = {
                action = "implementation";
                desc = "Goto Implementation";
              };
              gT = {
                action = "type_definition";
                desc = "Type Definition";
              };
              K = {
                action = "hover";
                desc = "Hover";
              };
              "<leader>cw" = {
                action = "workspace_symbol";
                desc = "Workspace Symbol";
              };
              "<leader>cr" = {
                action = "rename";
                desc = "Rename";
              };
              "<leader>ca" = {
                action = "code_action";
                desc = "Code Action";
              };
              "gK" = {
                action = "signature_help";
                desc = "Signature Help";
              };
            };
            diagnostic = {
              "<leader>cd" = {
                action = "open_float";
                desc = "Line Diagnostics";
              };
              "[d" = {
                action = "goto_prev";
                desc = "Previous Diagnostic";
              };
              "]d" = {
                action = "goto_next";
                desc = "Next Diagnostic";
              };
            };
          };
        };
      };

      keymaps = [
        {
          key = "<leader>fm";
          action = "<CMD>lua require('conform').format({ async = true, lsp_fallback = true })<CR>";
          options.desc = "Format the current buffer";
        }
        {
          key = "<leader>cl";
          action = "<CMD>lsp restart<CR>";
          options.desc = "Restart LSP";
        }
      ];
    };
  };
}
