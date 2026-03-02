{ config, pkgs, inputs, ...}:

{
  imports = [
    ./modules
    inputs.nixcord.homeModules.nixcord
    inputs.mango.hmModules.mango
  ];
  home = {
    stateVersion = "25.11";
    shell.enableFishIntegration = true;
    username = "shinyu";
    homeDirectory = "/home/shinyu";
    packages = with pkgs; [
      
    ];
  };
}
