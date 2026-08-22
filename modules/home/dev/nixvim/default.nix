{ inputs, ... }:
{
  flake.modules.homeManager.nixvim =
    {
      lib,
      pkgs,
      ...
    }:
    {
      imports = [ inputs.nixvim.homeModules.nixvim ];

      home.sessionVariables.EDITOR = "nvim";

      programs.nixvim = {
        enable = true;

        nixpkgs.config.allowUnfree = pkgs.config.allowUnfree;
        dependencies.gcc.package = null;
        plugins.web-devicons.enable = true;
        diagnostic.settings.virtual_lines.only_current_line = true;
        extraConfigVim = ''
          autocmd BufRead,BufNewFile *.pl set filetype=prolog
        '';

        opts = {
          updatetime = 100; # Faster completion

          number = true;
          relativenumber = true;
          splitbelow = true;
          splitright = true;
          scrolloff = 4;

          autoindent = true;
          clipboard = "unnamedplus";
          expandtab = true;
          shiftwidth = 2;
          smartindent = true;
          tabstop = 2;

          ignorecase = true;
          incsearch = true;
          smartcase = true;
          wildmode = "list:longest";

          swapfile = false;
          undofile = true; # Build-in persistent undo

          termguicolors = lib.mkForce pkgs.stdenv.hostPlatform.isLinux;
        };
      };
    };
}
