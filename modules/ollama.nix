{ pkgs, lib, config, ... }:

{

  options = {
    ollama.enable =
      lib.mkEnableOption "Enable ollama";
  };

  config = lib.mkIf config.ollama.enable { 
    services.ollama = {
      enable = true;
      acceleration = "rocm";
    };
  };
}
