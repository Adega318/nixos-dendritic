{
  flake.modules.homeManager.portfolio =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [ portfolio ];
    };
}
