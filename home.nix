{ pkgs, lib, config, stylix, ... }:
{	
	home.username = "edward";
	home.homeDirectory = "/home/edward";
	home.stateVersion = "23.11";
	home.packages = with pkgs; [
   		w3m
		kubectl
		duf
		nwg-displays
  	];
  

  stylix = {
    enable = true;
    autoEnable = true;
    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/ChrisTitusTech/nord-background/refs/heads/main/41.png";
      sha256 = "2a68ce8b7ee45b73d42d47543038848622b09e18d22ab98f79ccd210445297e9";
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml"; 
  };
 
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    settings = {
     decoration = {
      shadow_offset = "0 5";
      "col.shadow" = "rgba(00000099)";
    };

    "$mod" = "SUPER";

    bindm = [
      # mouse movements
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod ALT, mouse:272, resizewindow"
    ];
   };
  };


  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    completionInit = "autoload -U compinit && compinit";
  };

  programs.git = {
    enable = true;
    userEmail = "edward@edwardijk.nl";
    userName = "Edward Dijk";
  };
  
  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
  };

  programs.k9s = {
    enable = true;
  };
  

  programs.neovim = {
    enable = true;
  };

  programs.kitty = {
    enable = true;
  };

  programs.lsd = {
    enable = true;
    enableAliases = true;
  };

  programs.bat = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  programs.lazygit = {
    enable = true;
  };

  programs.btop = {
    enable = true;
    settings = {
      theme_background = false;
    };
  };

  programs.firefox = {
    enable = true;
  };

  programs.wofi.enable = true;
  programs.waybar.enable = true;
  services.swaync.enable = true;
  services.hyprpaper.enable = true;
  services.hypridle.enable = true;
  programs.hyprlock.enable = true;


  programs.home-manager.enable = true;
  
#  qt.enable = true;
#  qt.platformTheme.name = "gtk";
#  qt.style.name = "arc-dark";
#  qt.style.package = pkgs.arc-kde-theme;
#
#
#  gtk.enable = true;
#  gtk.theme = {
#    name = "Arc-Dark";
#    package = pkgs.arc-theme;
#  };
#
#  gtk.iconTheme = {
#    name = "Arc";
#    package = pkgs.arc-icon-theme;
#  };
#
}
