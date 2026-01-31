{ config, lib, pkgs, inputs, ... }:
{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    # package = pkgs.millennium-steam;
  };
}
