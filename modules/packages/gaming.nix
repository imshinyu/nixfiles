{ config, lib, pkgs, aagl, inputs, ... }:
{
  # nixpkgs.overlays = [ inputs.millennium.overlays.default ];
	imports = [ aagl.nixosModules.default ];
  nix.settings = aagl.nixConfig;
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    # package = pkgs.millennium-steam;
  };
  programs.gamemode.enable = true;
  programs.anime-game-launcher.enable = true;
  environment.systemPackages = with pkgs; [
    winetricks
    osu-lazer-bin
    wine
    mangohud
    umu-launcher
    ludusavi
    protonplus
    heroic
    pcsx2
    evtest
    inputs.xboxdrv.packages.${pkgs.stdenv.hostPlatform.system}.xboxdrv
  ];
}
