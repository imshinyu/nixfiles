{ config, lib, pkgs, inputs, ... }:
{
  imports =
    [
      ../../packages/qbittorrent.nix
      ../../packages/general.nix
      ../../packages/gaming.nix
      ../../packages/android.nix
    ];
  environment.systemPackages = with pkgs; [
    mumble
    upscayl
    blender
    jetbrains-toolbox
  ];
}
