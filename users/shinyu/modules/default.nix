{ config, lib, pkgs, inputs, ...}:
{
  imports = [
    ./nixcord.nix
    ../../../packages/mango/mango.nix
    ../../../packages/niri/niri.nix
    ../../../packages/quickshell/quickshell.nix
  ];
}
