{
  flake.modules.homeManager.alacritty = {
    programs.alacritty = {
      enable = true;
      settings.window = {
        padding = {
          x = 5;
          y = 5;
        };
        dynamic_padding = true;
      };
    };
    home.sessionVariables.TERMINAL = "alacritty";
  };
}
