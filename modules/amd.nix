{pkgs, config, lib, ... }:

{
  options = {
    amd.enable =
      lib.mkEnableOption "Enable Intel";
  };

  config = lib.mkIf config.amd.enable { 
    environment.systemPackages = with pkgs; [
      nvtopPackages.amd
      rocmPackages.rocminfo
    ];
  };

}
