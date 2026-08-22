{
  flake.modules.nixos.kde =
    { pkgs, config, ... }:
    let
      custom-sddm = pkgs.sddm-astronaut.override {
        themeConfig = {
          Background = "${config.stylix.image}";
          Font = config.stylix.fonts.serif.name;
        };
      };
    in
    {
      services = {
        desktopManager.plasma6.enable = true;
        displayManager.sddm = {
          enable = true;
          wayland.enable = true;
          autoNumlock = true;
          theme = "sddm-astronaut-theme";
          extraPackages = [ custom-sddm ];
        };
        xserver.enable = true;
      };

      environment.systemPackages = with pkgs; [
        # SDDM theme
        custom-sddm

        # KDE Utilities
        kdePackages.discover # Optional: Software center for Flatpaks/firmware updates
        kdePackages.kcalc # Calculator
        kdePackages.kcharselect # Character map
        kdePackages.kclock # Clock app
        kdePackages.kcolorchooser # Color picker
        kdePackages.kolourpaint # Simple paint program
        kdePackages.ksystemlog # System log viewer
        kdePackages.sddm-kcm # SDDM configuration module
        kdePackages.plasma-browser-integration # Browser integration
        kdiff3 # File/directory comparison tool

        # Hardware/System Utilities (Optional)
        kdePackages.isoimagewriter # Write hybrid ISOs to USB
        kdePackages.filelight # Disk space usage viewer
        kdePackages.partitionmanager # Disk and partition management
        kdePackages.kamoso # Camera app
        hardinfo2 # System benchmarks and hardware info
        wayland-utils # Wayland diagnostic tools
        wl-clipboard # Wayland copy/paste support
        vlc # Media player
      ];
    };
}
