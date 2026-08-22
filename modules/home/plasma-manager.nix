{ inputs, ... }:
{
  flake.modules.homeManager.plasma-manager = {
    imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

    programs.plasma = {
      enable = true;
      overrideConfig = true;

      session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";

      panels = [
        {
          location = "top";
          screen = "all";

          height = 32;
          floating = true;
          lengthMode = "fill";
          widgets = [
            {
              # App menu
              kickoff = {
                sortAlphabetically = true;
                icon = "nix-snowflake-white";
              };
            }
            {
              iconTasks = {
                launchers = [
                  "applications:org.kde.dolphin.desktop"
                  "applications:librewolf.desktop"
                  "applications:Alacritty.desktop"
                  "applications:dev.zed.Zed.desktop"
                  "applications:obsidian.desktop"
                ];
              };
            }
            "org.kde.plasma.panelspacer"
            "org.kde.plasma.digitalclock"
            "org.kde.plasma.panelspacer"
            {
              systemTray.items = {
                shown = [
                  "org.kde.plasma.volume"
                  "org.kde.plasma.bluetooth"
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.battery"
                ];
                hidden = [
                  "org.kde.plasma.clipboard"
                  "org.kde.plasma.brightness"
                ];
              };
            }
          ];
          hiding = "none";
        }
      ];

      #
      # Some mid-level settings:
      #
      shortcuts = {
        ksmserver = {
          "Lock Session" = [
            "Screensaver"
            "Meta+Ctrl+Alt+L"
          ];
        };

        kwin = {
          "Expose" = "Meta+,";
          "Window Maximize" = "Meta+F";
          "Window Fullscreen" = "Meta+Shift+F";
          "Window Minimize" = "Meta+M";
          "Switch Window Down" = "Meta+J";
          "Switch Window Left" = "Meta+H";
          "Switch Window Right" = "Meta+L";
          "Switch Window Up" = "Meta+K";
        };
      };

      input.keyboard = {
        numlockOnStartup = "on";

        layouts = [
          {
            layout = "us";
            variant = "intl";
          }
          { layout = "es"; }
        ];
      };

      #
      # Some low-level settings:
      #
      configFile = {
        "baloofilerc"."Basic Settings"."Indexing-Enabled" = false;
        "kwinrc"."org.kde.kdecoration2"."ButtonsOnLeft" = "SF";
      };
    };
  };
}
