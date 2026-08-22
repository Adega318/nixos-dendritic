{ config, ... }:
{
  configurations.homeManager.sam = {
    module =
      { pkgs, ... }:
      {
        # TODO: remove permittedInsecurePackages once it's no longer a transitive dependency
        nixpkgs.config.permittedInsecurePackages = [
          "electron-40.10.5"
          "ventoy-1.1.17"
        ];

        imports = with config.flake.modules.homeManager; [
          bottles
          discord
          gtk
          librewolf
          opencode
          plasma-manager
          udiskie

          # DEV
          dev

          # GAMES
          ff14
          heroic
          lutris
          minecraft
          ryujinx
          veloren

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
          ventoy # image writer
          bitwarden-desktop # bitwarden client
        ];
      };
  };
}
