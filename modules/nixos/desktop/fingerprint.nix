{
  flake.modules.nixos.fingerprint =
    {
      config,
      lib,
      ...
    }:
    {
      options.fingerprint.sudo = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable fingerprint authentication for sudo.";
      };

      options.fingerprint.kwallet = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable kwallet fingerprint auth";
      };

      config = {
        services.fprintd = {
          enable = true;
        };

        security.pam.services = {
          sudo.fprintAuth = config.fingerprint.sudo;

          login.kwallet.enable = config.fingerprint.kwallet;
          plasmalogin.kwallet.enable = config.fingerprint.kwallet;
        };
      };
    };
}
