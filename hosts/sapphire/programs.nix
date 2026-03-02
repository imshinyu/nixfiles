{ config, lib, pkgs, inputs, ... }:
{
  imports =
    [
      ../../modules/programs/qbittorrent.nix
      ../../modules/programs/packages.nix
      ../../modules/programs/gaming.nix
      ../../modules/programs/android.nix
    ];
  environment.systemPackages = with pkgs; [
    mumble
    upscayl
    blender
    jetbrains-toolbox
  ];
}
