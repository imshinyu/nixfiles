{ config, lib, pkgs, inputs, ... }:
{
  nixpkgs.overlays = [ inputs.millennium.overlays.default ];
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    package = pkgs.millennium-steam;
  };
  programs.gamemode.enable = true;
  environment.systemPackages = with pkgs; [
    winetricks
    osu-lazer-bin
    tetrio-desktop
    wine
    mangohud
    umu-launcher
    cartridges
    ludusavi
    heroic
    pcsx2
    evtest
    (wineWowPackages.stable.override { wineBuild = "wine64"; })
    inputs.xboxdrv.packages.${pkgs.stdenv.hostPlatform.system}.xboxdrv
    inputs.hyprism.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.sls-steam.packages.${pkgs.stdenv.hostPlatform.system}.wrapped
    inputs.online-fix-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.content-manager.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
