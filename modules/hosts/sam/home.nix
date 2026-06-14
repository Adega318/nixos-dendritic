{ config, ... }:
{
  configurations.homeManager.sam = {
    module =
      { pkgs, ... }:
      {
        imports = with config.flake.modules.homeManager; [
          bottles
          discord
          gtk
          librewolf
          opencode
          plasma-manager
          udiskie
          zen

          # DEV
          dev

          # GAMES
          ff14
          heroic
          lutris
          minecraft

          # OFFICE
          calibre
          obsidian
          onlyoffice
        ];

        home.packages = with pkgs; [
          winboat # windows as a container
          authenticator # Two factor authenticatort
          nextcloud-client # nextcloud desktop
          portfolio # invesment manager
          dbeaver-bin # db manager
          qbittorrent-enhanced # torrent
          teams-for-linux # teams
          postman # package sender
          chromium
          krita # paint
        ];
      };
  };
}
