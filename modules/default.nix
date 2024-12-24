{ pkgs, lib, config, ... }: {

  imports = [
    ./ollama.nix
    ./bluetooth.nix
    ./wireless.nix
  ];


  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;  
  boot.kernelParams = [ "quiet" "splash" "loglevel=3" ];
  
  boot.tmp = {
    useTmpfs = true;
    tmpfsSize = "50%";
  };

  nix = {
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
      package = pkgs.nix;
      settings = {
        auto-optimise-store = true;
        experimental-features = [ "nix-command" "flakes" ];
        substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
      };
  };

  networking.enableIPv6 = false;
  networking.networkmanager.enable = true; 
  networking.timeServers = [ "nl.pool.ntp.org" ];
  
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

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = [ "gtk" ];
  };

  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
  
  services.xserver.enable = true;  
  services.greetd = {
    enable = true;
    vt = 3;
    settings = {
      default_session = {
        user = "edward";
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland"; # start Hyprland with a TUI login manager
      };
    };
  };

  services.acpid.enable = true;
  services.chrony.enable = true;
  services.ntp.enable = false;
  services.fstrim.enable = true;
  services.smartd.enable = true;
  services.power-profiles-daemon.enable = true;
  services.psd.enable = true;
  services.fwupd = {
    enable = true;
    extraRemotes = [ "lvfs-testing" ];
  };
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PermitRootLogin = "no";
      X11Forwarding = false;
    };
  };

  systemd.coredump.enable = false;

  networking.firewall.enable = true;
  nixpkgs.config.allowUnfree = true;
  
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  system.stateVersion = "23.11"; 
}
