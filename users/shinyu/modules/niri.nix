{ config, lib, pkgs, inputs, ...}:
{
  home.file = {
    ".config/niri" = {
      recursive = true;
      source = "../../../dotfiles/niri";
    };
  };
}
