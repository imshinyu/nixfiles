{ config, lib, pkgs, inputs, ...}:
{
    home.file = {
      ".config/mango" = {
        recursive = true;
        source = ./mango;
      };
    };
}
