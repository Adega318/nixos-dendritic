{ config, ... }:
{
  configurations.nixos.dean = {
    # System options
    stateVersion = "26.05";
    wallpaper = ../../../wallpapers/lighthouse.png;
    base16Scheme = "catppuccin-mocha";

    # Modules
    module = {
      imports = with config.flake.modules.nixos; [
        bluetooth
        docker
        plymouth
        podman

        # CORE
        core

        # DESKTOP
        sddm
        kde
        desktop
        fingerprint
        bitwarden

        # SERVICES
        cockpit
        glances
        tailscale
        proton
      ];

      openssh.extraConfig = ''
        Host ssh-gitea.eadega.com
          ProxyCommand cloudflared access ssh --hostname %h
      '';

      cockpit.openTailscale = true;
      glances.openTailscale = true;
    };
  };
}
