{ config, lib, pkgs, inputs, ...}:

{
  imports = [
    ./home/default.nix
  ];
  home = {
    stateVersion = "25.11";
    username = "biscuit";
    homeDirectory = "/home/biscuit";
    packages = with pkgs; [
      
    ];
  };
}
