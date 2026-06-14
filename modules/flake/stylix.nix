{ inputs, ... }:
let
  stylix = pkgs: {
    enable = true;
    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 20;
    };

    fonts = {
      serif = {
        package = pkgs.nerd-fonts.agave;
        name = "Agave Nerd Font Serif";
      };
      sansSerif = {
        package = pkgs.nerd-fonts.agave;
        name = "Agave Nerd Font Sans Serif";
      };
      monospace = {
        package = pkgs.nerd-fonts.agave;
        name = "Agave Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
in
{
  flake.modules.nixos.stylix =
    { pkgs, ... }:
    {
      imports = [ inputs.stylix.nixosModules.stylix ];
      stylix = stylix pkgs;
    };

  flake.modules.homeManager.stylix =
    { pkgs, ... }:
    {
      imports = [ inputs.stylix.homeModules.stylix ];
      stylix = (stylix pkgs) // {
        targets = {
          firefox = {
            profileNames = [ "default" ];
            colorTheme.enable = true;
          };
          librewolf = {
            profileNames = [ "default" ];
            colorTheme.enable = true;
          };
          zen-browser = {
            profileNames = [ "default" ];
          };
        };
      };
    };
}
