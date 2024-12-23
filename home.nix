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
		lutris
		ipcalc
		bc
		pwgen
		noto-fonts-color-emoji
		font-awesome
		nerd-fonts.fira-mono
		kdePackages.dolphin
		kdePackages.okular
		streamcontroller
		qt6ct
		pcmanfm
  	];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    settings = {

      "$terminal" = "kitty";
      "$fileManager" = "pcmanfm";
      "$menu" = "wofi --show drun";
      "$webbrowser" = "firefox";

      general = {
        gaps_in = 5;
	gaps_out = 5;
	border_size = 2;
	layout = "dwindle";
      };

      misc = {
        disable_hyprland_qtutils_check = true;
      };
      
      decoration = {
        rounding = 10;
      };

      env = [
       "QT_QPA_PLATFORM,wayland"
       "QT_QPA_PLATFORMTHEME,qt6ct"
      ];

      exec-once = [
        "dbus-update-activation-environment --systemd --all"
        "waybar"
      ];

      "$mod" = "SUPER";
      bind = [
        "$mod, Q, exec, $terminal"
	"$mod, R, exec, $menu"
	"$mod, C, killactive,"
	"$mod, M, exit,"
	"$mod, E, exec, $filemanager"
	"$mod, V, togglefloating"
	"$mod, P, pseudo"
	"$mod, J, togglesplit"
	"$mod, W, exec, $webbrowser"
	"$mod, L, exec, hyprlock"
        
	"$mod, left, movefocus, l"
   	"$mod, right, movefocus, r"
   	"$mod, up, movefocus, u"
	"$mod, down, movefocus, d"

	"$mod, S, togglespecialworkspace, magic"
	"$mod SHIFT, S, movetoworkspace, special:magic"
      ];

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

  programs.fastfetch = {
    enable = true;
  };

  programs.firefox = {
    enable = true;
  };

  programs.wofi.enable = true;
  programs.waybar.enable = true;
  services.swaync.enable = true;
  services.hyprpaper.enable = true;
  services.hypridle.enable = true;
  services.easyeffects.enable = true;
  services.network-manager-applet.enable = true;
  programs.hyprlock.enable = true;


  programs.home-manager.enable = true;
  
  qt.enable = true;
  qt.platformTheme.name = "gtk3";
  qt.style.name = "arc-dark";
  qt.style.package = pkgs.arc-kde-theme;
#
#
#  gtk.enable = true;
#  gtk.theme = {
#   name = "Arc-Dark";
#    package = pkgs.arc-theme;
#  };  
  gtk = {
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    iconTheme = {
      name = "Arc";
      package = pkgs.arc-icon-theme;
    };
  };
}
