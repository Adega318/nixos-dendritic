{
  flake.modules.homeManager.veloren =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        veloren
      ];
    };
}
