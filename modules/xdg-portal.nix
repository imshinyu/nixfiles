{ config, pkgs, inputs, ... }:
{
  xdg.mime = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "firefox.desktop";
      "image/png" = "gwenview.desktop";
      "video/mp4" = "vlc.desktop";
      "x-scheme-handler/discord" = "discord.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "text/html" = "firefox.desktop";
    };
  };
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
    };
    mango = {
      default = [
        "gtk"
      ];
      "org.freedesktop.impl.portal.FileChooser" = [
        "lxqt"
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
