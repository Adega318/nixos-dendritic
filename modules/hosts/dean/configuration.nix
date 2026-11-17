{ config, ... }:
{
  configurations.nixos.dean = {
    # System options
    stateVersion = "26.05";
    wallpaper = ../../../wallpapers/lighthouse.png;
    base16Scheme = "catppuccin-mocha";

    # Modules
    module = {
      # HACK: remove this packages when not needed
      nixpkgs.config.permittedInsecurePackages = [
        "python3.14-python-jose-3.5.0"
      ];

      imports = with config.flake.modules.nixos; [
        bluetooth
        docker
        plymouth
        podman
        vm

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
