{ config, pkgs, inputs, ... }:
{
  xdg.portal.enable = true;
  xdg.portal.config = {
    common = {
      default = [
        "gtk"
      ];
    };
    mango = {
      default = [
        "gtk"
      ];
      "org.freedesktop.impl.portal.FileChooser" = [
        "kde"
      ];
    };
    niri = {
      default = [
        "gtk"
      ];
      "org.freedesktop.impl.portal.FileChooser" = [
        "kde"
      ];
    };
  };
}
