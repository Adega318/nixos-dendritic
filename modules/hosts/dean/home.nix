{ config, ... }:
{
  configurations.homeManager.dean = {
    module =
      { pkgs, ... }:
      {
        # HACK: remove permittedInsecurePackages once it's no longer a transitive dependency
        nixpkgs.config.permittedInsecurePackages = [
          "electron-40.10.5"
          "ventoy-1.1.17"
        ];

        imports = with config.flake.modules.homeManager; [
          bottles
          discord
          easyeffects
          gtk
          librewolf
          opencode
          plasma-manager
          udiskie

          # DEV
          dev

          # GAMES
          heroic
          lutris

          # OFFICE
          anki
          obsidian
          onlyoffice
        ];

        home.packages = with pkgs; [
          winboat # windows as a container
          nextcloud-client # nextcloud desktop
          yacreader # comic reader
          portfolio # invesment manager
          dbeaver-bin # db manager
          qbittorrent-enhanced # torrent
          teams-for-linux # teams
          bruno # package sender
        ];

        plasma-manager = {
          override = false;
          layouts = [ { layout = "es"; } ];
        };
      };
  };
}
