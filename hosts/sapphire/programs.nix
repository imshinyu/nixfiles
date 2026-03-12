{ config, lib, pkgs, inputs, ... }:
{
  imports =
    [
      ../../profiles/qbittorrent.nix
      ../../profiles/general.nix
      ../../profiles/gaming.nix
      ../../profiles/android.nix
      ../../profiles/nixcord.nix
      ../../profiles/spicetify.nix
    ];
  environment.systemPackages = with pkgs; [
    mumble
    upscayl
    blender
    jetbrains-toolbox
  ];
}
