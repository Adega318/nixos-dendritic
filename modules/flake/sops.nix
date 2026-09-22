{
  inputs,
  lib,
  ...
}:
let
  auth = ../../secrets/auth.yaml;
in
{
  flake.modules.nixos.sops =
    { pkgs, ... }:
    {
      imports = [ inputs.sops-nix.nixosModules.sops ];

      environment.systemPackages = with pkgs; [
        sops
        age
        ssh-to-age
      ];

      sops = {
        age.sshKeyPaths = [
          "/etc/ssh/ssh_host_ed25519_key"
        ];
        secrets =
          lib.genAttrs
            [
              "system/rootPassword"
              "system/userPassword"
            ]
            (_: {
              sopsFile = auth;
            });
      };
    };

  flake.modules.homeManager.sops = { config, ... }: {
    imports = [ inputs.sops-nix.homeManagerModules.sops ];

    sops = {
      age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      secrets =
        lib.genAttrs
          [
            "anki/username"
            "anki/password"
          ]
          (_: {
            sopsFile = auth;
          });
    };
  };
}
