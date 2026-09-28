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
          # Js, CSS, HTML, Yaml, Markdown, GraphQL
          prettierd
          prettier
          # spell
          codespell
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
                "prettierd"
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
                "prettierd"
                "prettier"
              ];
              html = [
                "prettierd"
                "prettier"
              ];
              css = [
                "prettierd"
                "prettier"
              ];
              yaml = [
                "prettierd"
                "prettier"
              ];
              "*" = [ "codespell" ];
            };
          };
        };
      };
    };
}
