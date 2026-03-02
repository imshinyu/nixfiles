{ config, lib, pkgs, inputs, ... }:
{
  imports =
    [
      ../../modules/programs/packages.nix
    ];
  environment.systemPackages = with pkgs; [
  ];
}
