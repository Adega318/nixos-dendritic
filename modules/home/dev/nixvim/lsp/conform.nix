{
  flake.modules.homeManager.nixvim =
    { pkgs, ... }:
    {
      programs.nixvim = {
        extraPackages = with pkgs; [
          # Nix
          nixfmt
          # Python
          ruff
          # Rust
          rustfmt
          leptosfmt
          # Markdown
          markdownlint-cli
          # Golang
          go # provides gofmt
          gotools # provides goimports
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
              lsp_format = "fallback";
              timeout_ms = 5000;
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
              javascript = [ "prettier" ];
              html = [ "djlint" ];
              css = [ "prettier" ];
              yaml = [ "prettier" ];
            };

            formatters.nixfmt.args = [ "-" ];
          };
        };
      };
    };
}
