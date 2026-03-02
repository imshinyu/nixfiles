{ config, pkgs, inputs, ...}:

{
  home = {
    stateVersion = "25.11";
    shell.enableFishIntegration = true;
    username = "family";
    homeDirectory = "/home/family";
    packages = with pkgs; [
      
    ];
  };
  
}
