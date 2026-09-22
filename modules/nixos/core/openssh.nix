{
  flake.modules.nixos.openssh =
    {
      config,
      lib,
      ...
    }:
    {
      options.openssh.extraConfig = lib.mkOption {
        type = lib.types.lines;
        default = "";
        description = "Extra client-side SSH configuration appended to programs.ssh.extraConfig.";
      };

      config = {
        services.openssh = {
          enable = true;
          ports = [ 22 ];
          settings = {
            PasswordAuthentication = false;
            AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
            UseDns = true;
            X11Forwarding = false;
            PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
          };
        };
        programs.ssh.extraConfig = config.openssh.extraConfig;
      };
    };
}
