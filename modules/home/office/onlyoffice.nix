{
  flake.modules.homeManager.onlyoffice = {
    programs.onlyoffice.enable = true;

    xdg.mimeApps = {
      enable = true;
      defaultApplications."application/pdf" = [ "onlyoffice-desktopeditors.desktop" ];
    };
  };
}
