{ config, lib, pkgs, inputs, ... }:
{
  disabledModules = [
    # "services/x11/desktop-managers/budgie.nix"
    "services/desktop-managers/plasma6.nix"
  ];
  imports = [
  # "${inputs.nixpkgs-unstable}/nixos/modules/services/desktop-managers/budgie.nix"
  # "${inputs.nixpkgs-unstable}/nixos/modules/programs/wayland/dms-shell.nix"
    "${inputs.nixpkgs-unstable}/nixos/modules/services/desktop-managers/plasma6.nix"
  ];
  nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-unstable;
  programs.mango.enable = true;
  # programs.wayfire = {
  #   enable = true;
  #   plugins = with pkgs.wayfirePlugins; [
  #     wcm
  #     wayfire-plugins-extra
  #     wf-shell
  #   ];
  # };
  # programs.labwc.enable = true;
  
  environment.pathsToLink = [ "/share/wayland-sessions" "/share/xsessions" ];

  environment.systemPackages = with pkgs; [
    # waybar
    # cosmic-ext-tweaks
    # xfce.xfce4-whiskermenu-plugin
    # xfce.xfce4-xkb-plugin
    # cagebreak
  ];
  # services.desktopManager.budgie.enable = true;
  # environment.budgie.excludePackages = with pkgs; [
  #   mate-terminal
  # ];
  # services.xserver.enable = true;
  # services.xserver.displayManager.startx.enable = true;
  # services.xserver.displayManager.startx.generateScript = true;
  # services.xserver.desktopManager.xfce.enable = true;
  # # services.xserver.desktopManager.budgie.enable = true;
  # services.xserver.desktopManager.xfce.enableWaylandSession = true;
  # services.xserver.desktopManager.xfce.waylandSessionCompositor = "wayfire";
  # services.xserver.desktopManager.cinnamon.enable = true;
  # environment.cinnamon.excludePackages = with pkgs; [
  #   blueman
  # ];

  # services.desktopManager.cosmic.enable = true;
  # services.desktopManager.cosmic.showExcludedPkgsWarning = false;
  # environment.cosmic.excludePackages = with pkgs; [
  #   cosmic-edit
  #   cosmic-bg
  #   cosmic-files
  #   cosmic-term
  #   cosmic-player
  #   cosmic-reader
  #   cosmic-store
  #   cosmic-initial-setup
  # ];

  # services.displayManager.sessionPackages = [ 
  #   pkgs.lxqt.lxqt-wayland-session 
  # ];
  # services.xserver.desktopManager.lxqt.enable = true;
  # environment.lxqt.excludePackages = with pkgs; [
  #   lxqt.qterminal
  # ];

  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    kwallet
    konsole
    kate
  ];
}
