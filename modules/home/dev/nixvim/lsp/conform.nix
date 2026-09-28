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
          # spell
          codespell
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
                "rustfmt"
                "leptosfmt"
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
              "*" = [ "codespell" ];
            };
          };
        };
      };
    };
}
