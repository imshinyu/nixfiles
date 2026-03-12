{ config, lib, pkgs, inputs, ... }:
{
  imports =
    [
      ../../profiles/general.nix
    ];
  environment.systemPackages = with pkgs; [
  ];
}
