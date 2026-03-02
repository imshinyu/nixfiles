{ config, pkgs, inputs, ... }:
{
  xdg.portal = {
    enable = true;
    # xdgOpenUsePortal = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      kdePackages.xdg-desktop-portal-kde
    ];
  };
  xdg.portal.config = {
    common = {
      default = [
        "gtk"
      ];
      "org.freedesktop.impl.portal.FileChooser" = [
        "nautilus"
      ];
    };
    mango = {
      default = [
        "gtk"
      ];
      "org.freedesktop.impl.portal.FileChooser" = [
        "nautilus"
      ];
    };
    niri = {
      default = [
        "gnome"
      ];
      "org.freedesktop.impl.portal.FileChooser" = [
        "nautilus"
      ];
    };
  };
}
