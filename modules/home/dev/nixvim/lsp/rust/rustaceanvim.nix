{
  flake.modules.homeManager.nixvim =
    { pkgs, ... }:
    let
      lldbExt = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb";
      liblldb =
        "${lldbExt}/lldb/lib/liblldb" + (if pkgs.stdenv.hostPlatform.isDarwin then ".dylib" else ".so");
    in
    {
      programs.nixvim.plugins.rustaceanvim = {
        enable = true;
        settings = {
          server = {
            on_attach.__raw = ''
              function(_, bufnr)
                local map = function(lhs, cmd, desc)
                  vim.keymap.set("n", lhs, function() vim.cmd.RustLsp(cmd) end,
                    { buffer = bufnr, silent = true, desc = "Rust: " .. desc })
                end
                map("K", { "hover", "actions" }, "Hover actions")
                map("<leader>ca", "codeAction", "Code action (grouped)")
                map("<leader>rr", "runnables", "Runnables")
                map("<leader>rt", "testables", "Testables")
                map("<leader>rD", "debuggables", "Debuggables")
                map("<leader>re", "expandMacro", "Expand macro")
                map("<leader>rE", "explainError", "Explain error")
                map("<leader>rd", "renderDiagnostic", "Render diagnostic")
                map("<leader>rc", "openCargo", "Open Cargo.toml")
                map("<leader>rp", "parentModule", "Parent module")
                map("<leader>rj", "joinLines", "Join lines")
                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
              end
            '';

            default_settings.rust-analyzer = {
              cargo = {
                allFeatures = true;
                buildScripts.enable = true;
                # separate target dir so r-a and `cargo build` don't block each other
                targetDir = true;
              };
              procMacro.enable = true;
              check = {
                command = "clippy";
                allTargets = true;
              };
              checkOnSave = true;
              diagnostics.enable = true;
              imports = {
                granularity.group = "module";
                prefix = "self";
              };
              completion = {
                callable.snippets = "fill_arguments";
                autoimport.enable = true;
              };
              inlayHints = {
                lifetimeElisionHints = {
                  enable = "always";
                  useParameterNames = true;
                };
                closureReturnTypeHints.enable = "with_block";
                bindingModeHints.enable = true;
                chainingHints.enable = true;
              };
              lens = {
                enable = true;
                references.adt.enable = true;
                references.method.enable = true;
              };
              files.excludeDirs = [
                "target"
                ".git"
                ".cargo"
                ".github"
                ".direnv"
              ];
            };
          };

          # Debugging via codelldb (uses the nvim-dap you already enable in python.nix)
          dap.adapter.__raw = ''
            require("rustaceanvim.config").get_codelldb_adapter(
              "${lldbExt}/adapter/codelldb",
              "${liblldb}"
            )
          '';
        };
      };

      home.packages = with pkgs; [
        clippy
        cargo-nextest
      ];
    };
}
