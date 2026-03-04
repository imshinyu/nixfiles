{ config, lib, pkgs, inputs, ...}:

{
  home = {
    stateVersion = "25.11";
    username = "family";
    homeDirectory = "/home/family";
    packages = with pkgs; [
      
    ];
  };
  
}
