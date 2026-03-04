{ config, lib, pkgs, inputs, ... }:
{
  imports =
    [
      ../../modules/packages/general.nix
    ];
  environment.systemPackages = with pkgs; [
  ];
}
