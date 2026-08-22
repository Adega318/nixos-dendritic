{
  flake.modules.homeManager.common-packages =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # LANGUAGE
        ## PYTHON
        python3
        ## NIX
        nixd
        nixfmt
        nil
        ## JAVA
        jdk
        maven

        # COMMANDS
        ## COMPRESED
        p7zip
        unzip
        unrar
        ## NETWORK
        inetutils
        dig
        cloudflared
        wget
        ## MEMORY
        tree
        parted
        ncdu
        ## SECURITY
        lynis
      ];
    };
}
