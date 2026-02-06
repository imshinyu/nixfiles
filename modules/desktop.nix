{ config, lib, pkgs, inputs, ... }:
{
  # disabledModules = [ "services/x11/desktop-managers/budgie.nix" ];
  # imports = [
  #   "${inputs.nixpkgs-unstable}/nixos/modules/services/desktop-managers/budgie.nix"
  # ];
  programs.niri.enable = true;
  programs.niri.useNautilus = false;
  programs.mango.enable = true;
  # programs.wayfire.enable = true;
  programs.labwc.enable = true;
  
  environment.pathsToLink = [ "/share/wayland-sessions" "/share/xsessions" ];

  environment.systemPackages = with pkgs; [
    # kdePackages.kwin
    # kdePackages.systemsettings
    # lxqt.pcmanfm-qt
  ];
  # services.desktopManager.budgie.enable = true;
  # environment.budgie.excludePackages = with pkgs; [
  #   mate-terminal
  # ];
  # services.xserver.desktopManager.xfce.enable = true;
  # services.xserver.desktopManager.xfce.enableWaylandSession = true;
  # services.xserver.desktopManager.xfce.waylandSessionCompositor = "wayfire";

  services.desktopManager.cosmic.enable = true;
  services.desktopManager.cosmic.showExcludedPkgsWarning = false;
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-edit
    cosmic-term
    cosmic-player
    cosmic-reader
    cosmic-store
    cosmic-initial-setup
  ];

  # services.displayManager.sessionPackages = [ 
  #   pkgs.lxqt.lxqt-wayland-session 
  # ];
  # services.xserver.desktopManager.lxqt.enable = true;
  # environment.lxqt.excludePackages = with pkgs; [
  #   lxqt.qterminal
  # ];

  # services.desktopManager.plasma6.enable = true;
  # environment.plasma6.excludePackages = with pkgs.kdePackages; [
  #   plasma-browser-integration
  #   konsole
  #   kate
  # ];
}
