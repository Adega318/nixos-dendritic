{
  flake.modules.homeManager.rustpkgs = { config, ... }: {
    home.sessionPath = [
      "${config.home.homeDirectory}/.cargo/bin"
    ];
  };
}
