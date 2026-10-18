{
  flake.modules.homeManager.nixvim =
    { pkgs, ... }:
    {
      programs.nixvim = {
        extraPackages = with pkgs; [
          # Nix
          nixfmt
          # Rust
          rustfmt
          leptosfmt
          # Markdown
          markdownlint-cli
          # Golang
          golangci-lint
          # Js, CSS, Yaml, Markdown, GraphQL
          prettier
          # HTML
          djlint
          # Shell
          shellharden
          shfmt
        ];

        plugins.conform-nvim = {
          enable = true;
          settings = {
            notify_on_error = true;
            format_on_save = {
              lspFallback = true;
              timeoutMs = 5000;
            };
            formatters_by_ft = {
              python = [
                "ruff_format"
                "ruff_organize_imports"
              ];
              go = [
                "gofmt"
                "goimports"
              ];
              nix = [ "nixfmt" ];
              markdown = [
                "markdownlint"
                "prettier"
              ];
              sh = [
                "shellharden"
                "shfmt"
              ];
              bash = [
                "shellharden"
                "shfmt"
              ];
              rust = [
                "leptosfmt"
                "rustfmt"
              ];
              javascript = [
                "prettier"
              ];
              html = [
                "djlint"
              ];
              css = [
                "prettier"
              ];
              yaml = [
                "prettier"
              ];
            };

            formatters.leptosfmt.condition.__raw = ''
              function(_, ctx)
                local manifest = vim.fs.find("Cargo.toml", { path = ctx.dirname, upward = true })[1]
                if not manifest then return false end
                for line in io.lines(manifest) do
                  if line:match("^%s*leptos") then return true end
                end
                return false
              end
            '';
          };
        };
      };
    };
}
