{ config, lib, pkgs, inputs, ...}:
{
  imports = [
    ./nixcord.nix
    ../../../modules/home/fastfetch.nix
    ../../../modules/home/fish.nix
    ../../../modules/home/foot.nix
    ../../../modules/home/gtk.nix
    ../../../modules/home/helix.nix
    ../../../modules/home/mako.nix
    ../../../modules/home/mango.nix
    ../../../modules/home/matugen.nix
    ../../../modules/home/niri.nix
    ../../../modules/home/quickshell.nix
    ../../../modules/home/rofi.nix
    ../../../modules/home/yazi.nix
    ../../../modules/home/qtengine.nix
  ];
}
