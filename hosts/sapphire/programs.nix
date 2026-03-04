{ config, lib, pkgs, inputs, ... }:
{
  imports =
    [
      ../../modules/packages/qbittorrent.nix
      ../../modules/packages/general.nix
      ../../modules/packages/gaming.nix
      ../../modules/packages/android.nix
    ];
  environment.systemPackages = with pkgs; [
    mumble
    upscayl
    blender
    jetbrains-toolbox
  ];
}
