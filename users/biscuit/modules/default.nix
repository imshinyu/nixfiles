{ config, lib, pkgs, inputs, ...}:
{
  imports = [
    ./nixcord.nix
    ./mango.nix
    ./niri.nix
    ./quickshell.nix
    ./spicetify.nix
  ];
}
