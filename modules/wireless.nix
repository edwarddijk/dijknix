{pkgs, lib, config, ...}:

{
  options = {
    wireless.enable =
      lib.mkEnableOption "Enable wireless";
  };

  config = lib.mkIf config.wireless.enable { 
 
    hardware.wirelessRegulatoryDatabase = true;
    networking.networkmanager.wifi.backend = "iwd";

    environment.systemPackages = with pkgs; [
     wavemon
     iwd
    ];
  };

}
