{ config, lib, pkgs, inputs, ... }:
{
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
