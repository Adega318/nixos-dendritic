{
  flake.modules.homeManager.librewolf = {
    nixpkgs.config.permittedInsecurePackages = [
      "librewolf-151.0.2-1"
      "librewolf-unwrapped-151.0.2-1"
    ];

    programs.librewolf = {
      enable = true;
      settings = {
        "webgl.disabled" = false;
        "privacy.resistFingerprinting" = false;
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.cookies" = false;
        "network.cookie.lifetimePolicy" = 0;
        "identity.fxaccounts.enabled" = true;
        "librewolf.webgl.prompt" = true;
      };

      profiles.default = {
        id = 0;
        isDefault = true;
        extensions.force = true;
      };
    };
  };
}
