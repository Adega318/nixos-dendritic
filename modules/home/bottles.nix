{
  flake.modules.homeManager.bottles =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        (bottles.override { removeWarningPopup = true; })
      ];
    };
}
