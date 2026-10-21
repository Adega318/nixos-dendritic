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
            # Don't show rust-analyzer server status/health notifications
            status_notify_level = false;

            # Swallow `window/showMessage` notifications sent by rust-analyzer,
            # so they don't pop up in nvim (noice/notify).
            # Errors are still available via `:RustLsp logFile`.
            handlers."window/showMessage".__raw = ''
              function(err, result, ctx, config)
                local client = ctx and vim.lsp.get_client_by_id(ctx.client_id)
                if client and client.name ~= "rust-analyzer" then
                  return vim.lsp.handlers["window/showMessage"](err, result, ctx, config)
                end
              end
            '';

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
                maxLength = 10;
                typeHints.enable = true;
                parameterHints.enable = false;

                chainingHints.enable = true;
                bindingModeHints.enable = true;

                closureReturnTypeHints.enable = "with_block";
                lifetimeElisionHints.enable = "skip_trivial";

                expressionAdjustmentHints.enable = "never";
                implicitDrops.enable = false;
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
              # Don't send the "can't find Cargo.toml" notification
              notifications.cargoTomlNotFound = false;
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
