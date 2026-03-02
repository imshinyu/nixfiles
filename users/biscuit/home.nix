{ config, pkgs, inputs, ...}:

{
  imports = [
    ./modules
    inputs.nixcord.homeModules.nixcord
  ];
  home = {
    stateVersion = "25.11";
    shell.enableFishIntegration = true;
    username = "biscuit";
    homeDirectory = "/home/biscuit";
    packages = with pkgs; [
      
    ];
  };
}
