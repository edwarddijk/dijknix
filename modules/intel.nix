{pkgs, config, lib, ... }:

{
  options = {
    intel.enable =
      lib.mkEnableOption "Enable Intel";
  };

  config = lib.mkIf config.intel.enable { 
    services.thermald.enable = true;
    environment.systemPackages = with pkgs; [
      nvtopPackages.intel
    ];
  };

}
