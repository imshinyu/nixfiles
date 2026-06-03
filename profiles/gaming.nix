{ config, lib, pkgs, inputs, ... }:
{
  # nixpkgs.overlays = [ inputs.millennium.overlays.default ];
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    # package = pkgs.millennium-steam;
  };
  programs.gamemode.enable = true;
  environment.systemPackages = with pkgs; [
    winetricks
    osu-lazer-bin
    tetrio-desktop
    wine
    mangohud
    umu-launcher
    ludusavi
    heroic
    pcsx2
    evtest
    (wineWowPackages.stable.override { wineBuild = "wine64"; })
    inputs.xboxdrv.packages.${pkgs.stdenv.hostPlatform.system}.xboxdrv
    inputs.elysia.packages.x86_64-linux.default
    inputs.omikuji.packages.x86_64-linux.default
    # inputs.hyprism.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
