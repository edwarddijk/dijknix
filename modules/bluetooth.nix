{pkgs, config, lib, ... }:

{
  options = {
    bluetooth.enable =
      lib.mkEnableOption "Enable Bluetooth";
  };

  config = lib.mkIf config.bluetooth.enable { 
    services.blueman.enable = true;
    hardware.bluetooth.enable = true;
  };

}
