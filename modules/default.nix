{ ... }: {

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
  };

  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz"; 
    keyMap = "us";
  };

  stylix = {
    enable = true;
    autoEnable = true;
    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/ChrisTitusTech/nord-background/refs/heads/main/41.png";
      sha256 = "2a68ce8b7ee45b73d42d47543038848622b09e18d22ab98f79ccd210445297e9";
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml"; 
    homeManagerIntegration.autoImport = true;
    polarity = "dark";
    opacity.terminal = 0.8;
    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";
    cursor.size = 24;
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.fira-mono;
        name = "FiraMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      serif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      sizes = {
        applications = 12;
        terminal = 12;
        desktop = 11;
        popups = 12;
      };
    };

  };

  security.sudo.wheelNeedsPassword = true;
