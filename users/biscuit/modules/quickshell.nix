{ config, lib, pkgs, inputs, ...}:
{
  home.file = {
    ".config/quickshell" = {
      recursive = true;
      source = "../../../dotfiles/quickshell";
    };
  };
}
