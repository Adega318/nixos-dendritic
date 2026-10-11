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

            # ── Collections ──────────────────────────────
            collection-fontsrecommended

            # ── Document classes & templates ─────────────
            ieeetran
            moderncv

            # ── Fonts & engines ──────────────────────────
            fontspec # requires XeTeX or LuaTeX
            libertine

            # ── Language & localization ──────────────────
            hyphen-spanish
            polyglossia

            # ── Page layout & typography ─────────────────
            fancyhdr
            geometry
            lettrine
            setspace
            titlesec
            wrapfig

            # ── Lists, floats & captions ─────────────────
            caption
            capt-of
            enumitem # provides \setlist

            # ── Tables ───────────────────────────────────
            booktabs
            tabular2

            # ── Colors, graphics & TikZ ──────────────────
            pgf # TikZ + PGF
            xcolor

            # ── Code listings ────────────────────────────
            listings

            # ── Dates ────────────────────────────────────
            datetime2
            datetime2-english
            datetime2-spanish

            # ── Glossaries & data ────────────────────────
            datatool
            datatool-english
            datatool-regions
            glossaries
            glossaries-english
            glossaries-spanish

            # ── Document structure & references ──────────
            appendix
            footnotebackref
            hyperref
            tocbibind

            # ── Text effects & utilities ─────────────────
            blindtext
            silence
            ulem

            # ── Preview & export ─────────────────────────
            dvipng
            dvisvgm
            preview
            ;
        };
      };
    };
}
