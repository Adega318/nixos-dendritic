{
  flake.modules.homeManager.ryujinx =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        ryubing
      ];
    };
}
