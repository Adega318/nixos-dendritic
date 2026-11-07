{
  flake.modules.homeManager.zed =
    { pkgs, ... }:
    {
      home.sessionVariables.VISUAL = "zeditor";
      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "text/plain" = "dev.zed.Zed.desktop";
        };
      };

      programs.zed-editor = {
        enable = true;

        # Faked lib structure for extensions with library requirements to work
        package = pkgs.zed-editor.fhsWithPackages (
          p: with p; [
            stdenv.cc.cc
            openssl
            glib
            zlib
          ]
        );

        extensions = [
          "nix"
          "toml"
          "rust"
          "html"
          "css"
        ];
        extraPackages = with pkgs; [
          # Nix
          nil
          nixd
          # Rust
          rustfmt
          # IA
          opencode
        ];
      };
    };
}
