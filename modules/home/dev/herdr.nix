{
  flake.modules.homeManager.herdr =
    { config, pkgs, ... }:
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

      programs.opencode.cli.plugins = [ "./herdr-opencode" ];

      xdg.configFile = {
        "opencode/plugins/herdr-agent-state.js".source = "${opencodeIntegration}/herdr-agent-state.js";
        "opencode/herdr-tui-session.js".source = "${opencodeIntegration}/herdr-tui-session.js";
        "opencode/herdr-opencode".source = "${opencodeTui}/herdr-opencode";
      };

      assertions = [
        {
          assertion = config.programs.opencode.enable;
          message = "The Herdr OpenCode integration requires `programs.opencode.enable = true`.";
        }
      ];
    };
}
