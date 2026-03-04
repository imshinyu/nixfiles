{ config, lib, pkgs, inputs, ...}:

{
  imports = [
    ./home/default.nix
  ];
  home = {
    stateVersion = "25.11";
    username = "shinyu";
    homeDirectory = "/home/shinyu";
    packages = with pkgs; [
    ];
  };
}
