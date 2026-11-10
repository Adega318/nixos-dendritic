{
  flake.modules.homeManager.herdr =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      herdr = if config.programs.herdr.package != null then config.programs.herdr.package else pkgs.herdr;
      opencodeIntegration = "${herdr}/share/herdr/integrations/opencode";
      opencodeTui = pkgs.runCommand "herdr-opencode-tui" { } ''
        install -Dm644 ${opencodeIntegration}/tui.js $out/herdr-opencode/tui.js
        install -Dm644 ${opencodeIntegration}/herdr-tui-session.js $out/herdr-tui-session.js
      '';
    in
    {
      programs.herdr = {
        enable = true;
        mutableSettings = true;
      };

      programs.opencode.cli.plugins = lib.optionals config.programs.opencode.enable [
        "./herdr-opencode"
      ];

      xdg.configFile = lib.mkIf config.programs.opencode.enable {
        "opencode/plugins/herdr-agent-state.js".source = "${opencodeIntegration}/herdr-agent-state.js";
        "opencode/herdr-tui-session.js".source = "${opencodeIntegration}/herdr-tui-session.js";
        "opencode/herdr-opencode".source = "${opencodeTui}/herdr-opencode";
      };

    };
}
