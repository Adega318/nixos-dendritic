{
  flake.modules.homeManager.easyeffects = {
    services.easyeffects = {
      enable = true;

      preset = "rnnoise";

      extraPresets = {
        rnnoise = {
          input = {
            blocklist = [ ];

            plugins_order = [
              "rnnoise#0"
            ];

            "rnnoise#0" = {
              bypass = false;
              "enable-vad" = false;
              "input-gain" = 0.0;
              "output-gain" = 0.0;
              "model-path" = "";
              release = 20.0;
              "vad-thres" = 50.0;
              wet = 0.0;
            };
          };
        };
      };
    };
  };
}
