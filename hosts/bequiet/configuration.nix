# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
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

  networking.hostName = "DijkNix"; # Define your hostname.
  networking.enableIPv6 = false;
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.timeServers = [ "nl.pool.ntp.org" ];

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
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
     font = "Lat2-Terminus16";
     keyMap = "us";
  };

  xdg.portal = {
  	enable = true;
	extraPortals = with pkgs; [
    		xdg-desktop-portal-gtk
		xdg-desktop-portal-hyprland
  	];
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
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
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
        terminal = 15;
        desktop = 11;
        popups = 12;
      };
    };

   };

  security.sudo.wheelNeedsPassword = true;

  services.xserver.enable = true;  
  services.greetd = {
      enable = true;
      vt = 3;
      settings = {
        default_session = {
          # Wayland Desktop Manager is installed only for user ryan via home-manager!
          user = "edward";
          # .wayland-session is a script generated by home-manager, which links to the current wayland compositor(sway/hyprland or others).
          # with such a vendor-no-locking script, we can switch to another wayland compositor without modifying greetd's config here.
          # command = "$HOME/.wayland-session"; # start a wayland session directly without a login manager
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland"; # start Hyprland with a TUI login manager
        };
      };
    };

  services.flatpak.enable = true;

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.pulseaudio.enable = false;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.edward = {
     isNormalUser = true;
     extraGroups = [ "wheel" "input" "video" "gamemode" ]; # Enable ‘sudo’ for the user.
     description = "Edward Dijk";
     hashedPassword = "$6$zwpADXuBZW.TrsZc$k82uFvhoeJ9/ir.ktaXo09CtJYYcfQTEFuBpdEaYepWvlxteRjO6w0KhphKbjBmM04xTXu7d9izGTSlUzr3ZK/";
     shell = pkgs.zsh;
  #   packages = with pkgs; [
  #     firefox
  #     tree
  #   ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    dconf
    tpm2-tss
    gcc
    go
    gopls
    luarocks
    ripgrep
    system-config-printer
    appimage-run
   ];

  # OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };


  # Hyprland
  # programs.hyprland.enable = true;
  # programs.hyprland.xwayland.enable = true;
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
  programs.steam.enable = true;
  programs._1password.enable = true;
  programs._1password-gui.enable = true;
  programs.zsh.enable = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.dconf = {
    enable = true;
  };
  
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PermitRootLogin = "no";
      X11Forwarding = false;
    };
  };

  systemd.coredump.enable = false;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.auto-optimise-store = true;
	  gc = {
	    automatic = true;
	    dates = "weekly";
	    options = "--delete-older-than 7d";
	  };
	  package = pkgs.nix;
	  settings.experimental-features = [ "nix-command" "flakes" ];
	};

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}
