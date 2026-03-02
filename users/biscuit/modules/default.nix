{ config, lib, pkgs, inputs, ...}:
{
  imports = [
    ./nixcord.nix
    ./spicetify.nix
    ../../../packages/quickshell/quickshell.nix
  ];
}
