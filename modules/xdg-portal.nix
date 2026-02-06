{ config, pkgs, inputs, ... }:
{
  xdg.portal = {
    enable = true;
    # xdgOpenUsePortal = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      kdePackages.xdg-desktop-portal-kde
    ];
  };
  xdg.portal.config = {
    common = {
      default = [
        "gtk"
      ];
      "org.freedesktop.impl.portal.FileChooser" = [
        "kde"
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
        "wlr;gtk"
      ];
      "org.freedesktop.impl.portal.FileChooser" = [
        "kde"
      ];
    };
  };
}
