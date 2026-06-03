{ config, pkgs, inputs, ... }:
{
  xdg.portal = {
    enable = true;
    # xdgOpenUsePortal = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };
  xdg.portal.config = {
    common = {
      default = [
        "gtk"
      ];
      "org.freedesktop.impl.portal.FileChooser" = [
        "gtk"
      ];
    };
    mango = {
      default = [
        "gtk"
      ];
      "org.freedesktop.impl.portal.FileChooser" = [
        "gtk"
      ];
    };
    niri = {
      default = [
        "hyprland;gtk"
      ];
      "org.freedesktop.impl.portal.FileChooser" = [
        "gtk"
      ];
    };
  };
}
