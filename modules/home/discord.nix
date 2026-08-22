{
  flake.modules.homeManager.discord = {
    nixpkgs.config.permittedInsecurePackages = [
      "pnpm-10.29.2"
    ];

    programs.vesktop = {
      enable = true;

      vencord.settings = {
        autoUpdate = true;
        autoUpdateNotification = false;
        notifyAboutUpdates = false;
        useQuickCss = true;
        disableMinSize = true;
        plugins = {
          MessageLogger = {
            enabled = true;
            ignoreSelf = true;
          };
          FakeNitro.enabled = true;
          clearURLs.enabled = true;
        };
      };
    };
  };
}
