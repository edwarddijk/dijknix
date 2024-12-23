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
		kdePackages.okular
		streamcontroller
		qt6ct
		pcmanfm
		spotify
  	];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    settings = {

      "$terminal" = "kitty";
      "$filemanager" = "pcmanfm";
      "$menu" = "wofi --show drun";
      "$webbrowser" = "firefox";
     
      source = [
        "~/.config/hypr/monitors.conf"
	"~/.config/hypr/workspaces.conf"
      ];

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

	"$mod, 1, workspace, 1"
	"$mod, 2, workspace, 2"
	"$mod, 3, workspace, 3"
	"$mod, 4, workspace, 4"
	"$mod, 5, workspace, 5"
	"$mod, 6, workspace, 6"
	"$mod, 7, workspace, 7"
	"$mod, 8, workspace, 8"
	"$mod, 9, workspace, 9"
	"$mod, 0, workspace, 10"
      	
	"$mod SHIFT, 1, movetoworkspace, 1"
	"$mod SHIFT, 2, movetoworkspace, 2"
	"$mod SHIFT, 3, movetoworkspace, 3"
	"$mod SHIFT, 4, movetoworkspace, 4"
	"$mod SHIFT, 5, movetoworkspace, 5"
	"$mod SHIFT, 6, movetoworkspace, 6"
	"$mod SHIFT, 7, movetoworkspace, 7"
	"$mod SHIFT, 8, movetoworkspace, 8"
	"$mod SHIFT, 9, movetoworkspace, 9"
	"$mod SHIFT, 0, movetoworkspace, 10"
 
      ];

      bindl = [
      # Requires playerctl
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioNext, exec, playerctl next"
      ];

      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];
   };
  };

  xdg = {
    userDirs = {
     enable = true;
     createDirectories = true;
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
    settings = {
      scrollback_lines = 2000;
      wheel_scroll_min_lines = 1;
      window_padding_with = 4;
      confirm_os_window_close = 0;
      enable_audio_bell = "no";
    };
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
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
	position = "top";
	height = 30;
	spacing = 4;
	modules-left = [
          "hyprland/workspaces"
	];
	modules-center = [
	  "hyprland/window"
	];
	modules-right = [
	  "idle_inhibitor"
	  "pulseaudio"
	  "network"
	  "power-profiles-daemon"
	  "cpu"
	  "memory"
	  "temperature"
	  "backlight"
	  "battery"
	  "clock"
	  "tray"
	];
       "hyprland/workspaces" = {
        "active-only" = false;
	"all-outputs" = true;
	"format" = "{icon}";
	"format-icons" = {
             "1"= "";
             "2"= "";
             "3"= "";
             "4"= "";
             "5"= "";

             "urgent"= "";
             "focused"= "";
             "default"= "";
         };
        };
       "hyprland/window" = {
        "format" = "{title}";
	"rewrite" = {
	    "(.*) Mozilla Firefox" = "  $1";
	    "(.*) Alacritty" = " $1";
	};
	"seperate-outputs" = true;
       };

       "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
            "activated"= "";
            "deactivated"= "";
           };
        };
        "tray" = {
        # "icon-size": 21,
        "spacing" = 10;
       };
       "clock" = {
        # "timezone": "America/New_York",
        "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        "format-alt" = "{:%Y-%m-%d}";
      };
       "cpu" = {
        "format"= "{usage}% ";
        "tooltip" = false;
      };
     "memory" = {
        "format" = "{}% ";
     };
    "temperature" = {
        # "thermal-zone": 2,
        # "hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input",
        "critical-threshold" = 80;
        # "format-critical": "{temperatureC}°C {icon}",
        "format" = "{temperatureC}°C {icon}";
        "format-icons" = ["" "" ""];
      };
      "backlight" = {
        # // "device": "acpi_video1";
        "format" = "{percent}% {icon}";
        "format-icons" = ["" "" "" ""  "" "" "" "" ""];
      };
    "battery" = {
        "states" = {
            #// "good" = 95,
            "warning" = 30;
            "critical" = 15;
        };
        "format" = "{capacity}% {icon}";
        "format-full" = "{capacity}% {icon}";
        "format-charging" = "{capacity}% ";
        "format-plugged" = "{capacity}% ";
        "format-alt" = "{time} {icon}";
        # "format-good" = ""; // An empty format will hide the module
        # "format-full" = "";
        "format-icons" = ["" "" "" "" ""];
    };
   "power-profiles-daemon" = {
      "format" = "{icon}";
      "tooltip-format" = "Power profile: {profile}\nDriver: {driver}";
      "tooltip" = true;
      "format-icons" = {
        "default" = "";
        "performance" = "";
        "balanced" = "";
        "power-saver" = "";
      };
    };
    "network" = {
        # "interface" = "wlp2*"; // (Optional) To force the use of this interface
        "format-wifi" = "{essid} ({signalStrength}%) ";
        "format-ethernet" = "{ipaddr}/{cidr} ";
        "tooltip-format" = "{ifname} via {gwaddr} ";
        "format-linked" = "{ifname} (No IP) ";
        "format-disconnected" = "Disconnected ⚠";
        "format-alt" = "{ifname}: {ipaddr}/{cidr}";
    };
    "pulseaudio" = {
        # "scroll-step" = 1, // %, can be a float
        "format" = "{volume}% {icon} {format_source}";
        "format-bluetooth" = "{volume}% {icon} {format_source}";
        "format-bluetooth-muted" = " {icon} {format_source}";
        "format-muted" = " {format_source}";
        "format-source" = "{volume}% ";
        "format-source-muted" = "";
        "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = ["" "" ""];
        };
        "on-click" = "pavucontrol";
    };

      };
    };
  };

  services.swaync.enable = true;
  services.hyprpaper.enable = true;
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
	ignore_dbus_inhibit = false;
	lock_cmd = "hyprlock";
      };
      listener = [
        {
	  timeout = 900;
	  on-timeout = "hyprlock";
	}
	{
	  timeout = 1200;
	  on-timeout = "hyprctl dispatch dpms off";
	  on-resume = "hyprctl dispatch dpms on";
	}
      ];
    };
  };

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
