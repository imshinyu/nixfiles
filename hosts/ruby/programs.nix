{ config, lib, pkgs, inputs, ... }:
{
  imports =
    [
      ../../packages/general.nix
    ];
  environment.systemPackages = with pkgs; [
  ];
}
