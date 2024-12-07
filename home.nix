{ pkgs, lib, config,... }:
{	
	home.username = "edward";
	home.homeDirectory = "/home/edward";
	home.stateVersion = "23.11";
	home.packages = with pkgs; [
   		w3m
  	];

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
    plugins = [ pkgs.tmuxPlugins.gruvbox ];
  };
 
  programs.neovim = {
    enable = true;
  };

  programs.kitty = {
    enable = true;
    themeFile = "GruvboxMaterialDarkMedium";
  };

  programs.lsd = {
    enable = true;
    enableAliases = true;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "gruvbox-dark";
    };
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
      color_theme = "gruvbox_dark";
      theme_background = false;
    };
  };

  programs.firefox = {
    enable = true;
  };

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
