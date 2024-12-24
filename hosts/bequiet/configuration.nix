# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:
let
  hostName = "DijkNix";
  userName = "edward";
in
{

  imports = [
    ../../modules
  ];
 
  # Options
  ollama.enable = true;
  bluetooth.enable = false;
  wireless.enable = false;


  networking.hostName = hostName; # Define your hostname.
  
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
  users.users.${userName} = {
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
    pavucontrol
    playerctl
    rocmPackages.rocminfo
    nvtopPackages.amd
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
  
}
