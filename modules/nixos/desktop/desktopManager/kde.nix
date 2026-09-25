{
  flake.modules.nixos.kde =
    { pkgs, ... }:
    {
      services = {
        desktopManager.plasma6.enable = true;
        xserver.enable = true;
      };

      environment.systemPackages = with pkgs; [
        # KDE Utilities
        kdePackages.discover # Optional: Software center for Flatpaks/firmware updates
        kdePackages.kcalc # Calculator
        kdePackages.kcharselect # Character map
        kdePackages.kclock # Clock app
        kdePackages.kcolorchooser # Color picker
        kdePackages.kolourpaint # Simple paint program
        kdePackages.ksystemlog # System log viewer
        kdePackages.sddm-kcm # SDDM configuration module
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

      environment.plasma6.excludePackages = with pkgs; [
        kdePackages.elisa # Music player
        kdePackages.kdepim-runtime # Akonadi agents
        kdePackages.kmahjongg
        kdePackages.kmines
        kdePackages.konversation # IRC client
        kdePackages.kpat # Solitaire
        kdePackages.ksudoku
        kdePackages.ktorrent
        kdePackages.plasma-browser-integration
        kdePackages.kate
      ];
    };
}
