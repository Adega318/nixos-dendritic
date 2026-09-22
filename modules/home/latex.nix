{
  flake.modules.homeManager.latex =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.texstudio
      ];

      programs.texlive = {
        enable = true;
        extraPackages = tpkgs: {
          inherit (tpkgs)
            scheme-basic
            # CV specific
            moderncv
            collection-fontsrecommended
            # TikZ ecosystem
            pgf
            # Required for \setlist command
            enumitem # For customizing lists
            # Preview and export
            dvisvgm
            dvipng
            preview
            # Common packages
            setspace
            wrapfig
            amsmath
            ulem
            hyperref
            capt-of
            xcolor
            fontspec
            geometry
            fancyhdr
            titlesec
            tabular2
            booktabs
            ;
        };
      };
    };
}
