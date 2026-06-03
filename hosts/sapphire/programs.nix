{ config, lib, pkgs, inputs, ... }:
{
  imports =
    [
      # ../../programs/qbittorrent.nix
      ../../profiles/general.nix
      ../../profiles/gaming.nix
      ../../profiles/android.nix
      # ../../programs/nixcord.nix
      ../../programs/spicetify.nix
    ];
  environment.systemPackages = with pkgs; [
  ];
}
