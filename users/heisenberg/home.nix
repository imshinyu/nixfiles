{ config, pkgs, inputs, ...}:

{
  home = {
    stateVersion = "25.11";
    shell.enableFishIntegration = true;
    username = "heisenberg";
    homeDirectory = "/home/heisenberg";
    packages = with pkgs; [
      
    ];
  };
}
