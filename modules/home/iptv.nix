{
  flake.modules.homeManager.iptv = { pkgs, ... }: {
    home.packages = with pkgs; [
      iptvnator
      mpv
    ];
  };
}
